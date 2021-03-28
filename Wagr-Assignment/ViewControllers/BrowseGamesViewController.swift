//
//  ViewController.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import UIKit
import Network
import os.log
import FirebaseAnalytics

class BrowseGamesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    // MARK: - Enums
    
    private enum Constants {
        static let tableViewRowHeight: CGFloat = 44.0
        static let offlineImageSize: CGFloat = 24.0
    }
    
    // MARK: - Private Properties
    
    private var games: [Game] = [] {
        didSet {
            gameSorter = GameSorter(games: games)
        }
    }
    private var gameSorter = GameSorter(games: [])
    private var fetchingGames = false
    private lazy var offlineIndicator: UIBarButtonItem = {
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(UIImage.offline, for: .normal)
        menuBtn.tintColor = UIColor.foreground
        menuBtn.addTarget(self, action: #selector(offlineButtonPressed), for: .touchUpInside)
        
        let button = UIBarButtonItem(customView: menuBtn)
        NSLayoutConstraint.activate([
            button.customView!.heightAnchor.constraint(equalToConstant: Constants.offlineImageSize),
            button.customView!.widthAnchor.constraint(equalToConstant: Constants.offlineImageSize),
        ])
        
        return button
    }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        configureUI()
        addNetworkObserver()
        updateConnectionStatus()
        fetchGames()
        logAnalytics()
    }
    
    // MARK: - Private Methods
    
    private func registerCells() {
        tableView.register(UINib(nibName: GameCell.identifier, bundle: nil), forCellReuseIdentifier: GameCell.identifier)
        tableView.register(DateHeader.self, forHeaderFooterViewReuseIdentifier: DateHeader.identifier)
    }
    
    private func configureUI() {
        
        self.tableView.setValue(UIColor.background , forKey: "tableHeaderBackgroundColor")
        
        // Nav Bar Appearance
        let defaultLargeFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        let defaultFont = UIFont.preferredFont(forTextStyle: .headline)
        let largeAttrs = [NSAttributedString.Key.font: UIFont(name: "Quicksand-Regular", size: defaultLargeFont.pointSize)!]
        let attrs = [NSAttributedString.Key.font: UIFont(name: "Quicksand-SemiBold", size: defaultFont.pointSize)!]
        UINavigationBar.appearance().largeTitleTextAttributes = largeAttrs
        UINavigationBar.appearance().titleTextAttributes = attrs
        navigationController?.navigationBar.largeTitleTextAttributes = largeAttrs
        navigationController?.navigationBar.titleTextAttributes = attrs
    }
    
    private func fetchGames() {
        
        if let cachedGames = fetchGamesFromCache() {
            reload(with: cachedGames)
        }
        
        fetchGamesFromAPI()
    }
    
    private func fetchGamesFromAPI() {
        guard fetchingGames == false else {
            return
        }
        fetchingGames = true
        NetworkManager.fetchGames() { [weak self] error, games in
            guard let self = self else { return }
            if let error = error {
                os_log(.error, "Error fetching games: %@", error.localizedDescription)
                return
            }
            
            let games = self.fetchGamesFromCache() ?? []
            
            self.reload(with: games)
        }
    }
    
    private func fetchGamesFromCache() -> [Game]? {
        return Game.fetchAllFromCache()
    }
    
    private func reload(with games: [Game]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.games = games
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.fetchingGames = false
        }
    }
    
    private func setIsOffline(_ offline: Bool) {
        
        let indicatorIsVisible = navigationItem.rightBarButtonItem != nil
        if offline, !indicatorIsVisible {
            navigationItem.rightBarButtonItem = offlineIndicator
        } else if !offline, indicatorIsVisible {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func offlineButtonPressed() {
        
        let title = NSLocalizedString("games-list-offline-title", comment: "")
        let message = NSLocalizedString("games-list-offline-message", comment: "")
        let ok = NSLocalizedString("ok", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default))
        
        present(alert, animated: true)
    }
    
    private func logAnalytics() {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: "BrowseGamesViewController"])
    }

}

// MARK: - TableView Delegate/DataSource

extension BrowseGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let gamesOnDay = gameSorter.sortedGames[indexPath.section] else {
            return UITableViewCell()
        }
        
        let game = gamesOnDay[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(with: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let games = gameSorter.sortedGames[section] else {
            return 0
        }
        return games.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(gameSorter.sortedGames.count)
        return gameSorter.sortedGames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateHeader.identifier) as! DateHeader
        header.update(title: Date.stringforDaysInFuture(section))

        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}

// MARK: - Network Reachability

extension BrowseGamesViewController: NetworkReachabilityObserver {
    
    func statusDidChange(status: NWPath.Status) {
        
        if status == .satisfied {
            setIsOffline(false)
            fetchGamesFromAPI()
        } else {
            setIsOffline(true)
        }
    }
    
    private func addNetworkObserver() {
        #if targetEnvironment(simulator)
            // Don't add, this feature is unstable on sims
        #else
        NetworkReachabilityService.shared().addObserver(observer: self)
        #endif
    }
    
    private func updateConnectionStatus() {
        let isOffline = NetworkReachabilityService.shared().currentStatus != .satisfied
        setIsOffline(isOffline)
    }
    
}
