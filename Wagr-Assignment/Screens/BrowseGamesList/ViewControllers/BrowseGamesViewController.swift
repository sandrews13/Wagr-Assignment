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
    
    // MARK: - Enums
    
    private enum Constants {
        static let tableViewRowHeight: CGFloat = 44.0
        static let offlineImageSize: CGFloat = 24.0
        static let cellOriginYThreshold: CGFloat = 180.0
    }
    
    // MARK: - Internal Properties
    
    var activeSection = 0
    var gameSorter = GameSorter(games: [])
    var changingSection = false
    var gamesView: BrowseGamesView {
        return self.view as! BrowseGamesView
    }
    
    // MARK: - Private Properties
    
    private var games: [Game] = [] {
        didSet {
            gameSorter = GameSorter(games: games)
        }
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesView.configureUI()
        configureUI()
        addNetworkObserver()
        updateConnectionStatus()
        fetchGames()
        logAnalytics()
    }

}

// MARK: - UI Functions

extension BrowseGamesViewController {
    
    private func configureUI() {
        
        // Nav Bar Appearance
        self.title = NSLocalizedString("games", comment: "")
        let defaultLargeFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        let defaultFont = UIFont.preferredFont(forTextStyle: .headline)
        let largeAttrs = [NSAttributedString.Key.font: UIFont(name: "Quicksand-Regular", size: defaultLargeFont.pointSize)!]
        let attrs = [NSAttributedString.Key.font: UIFont(name: "Quicksand-SemiBold", size: defaultFont.pointSize)!]
        UINavigationBar.appearance().largeTitleTextAttributes = largeAttrs
        UINavigationBar.appearance().titleTextAttributes = attrs
        navigationController?.navigationBar.largeTitleTextAttributes = largeAttrs
        navigationController?.navigationBar.titleTextAttributes = attrs
    }
    
    private func reload(with games: [Game]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.games = games
            self.gamesView.reload()
            self.fetchingGames = false
        }
    }
    
}

// MARK: - Networking

extension BrowseGamesViewController {
    
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
    
}

// MARK: - Offline Functions

extension BrowseGamesViewController {
    
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
    
}

// MARK: - Analytics

extension BrowseGamesViewController {
    
    private func logAnalytics() {
        AnalyticsManager.logScreenView(screenName: "BrowseGamesViewController")
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
