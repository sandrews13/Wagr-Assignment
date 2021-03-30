//
//  FullScreenCelebrationViewController.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import UIKit
import os.log

class FullScreenCelebrationViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var betLabel: UILabel!
    @IBOutlet private weak var betTextLabel: UILabel!
    @IBOutlet private weak var celebrationImage: UIImageView!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var gameView: UIView!
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let titleFontSize: CGFloat = 26
        static let messageFontSize: CGFloat = 18
        static let betFontSize: CGFloat = 24
        static let betTextFontSize: CGFloat = 20
        static let buttonFontSize: CGFloat = 20
    }
    
    // MARK: - Private Properties
    
    private let game: Game
    private lazy var gradientLayer: AnimatedGradientLayer = {
        let layer = AnimatedGradientLayer(host: self.backgroundView)
        
        return layer
    }()
    
    // MARK: - Initializers
    
    init(game: Game) {
        self.game = game
        super.init(nibName: "FullScreenCelebrationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        logAnalytics()
        setRandomImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientLayer.startAnimation()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        backgroundView.layer.cornerRadius = Constants.cornerRadius
        okButton.layer.cornerRadius = Constants.cornerRadius
        gradientLayer.animationDelegate = self
        gradientLayer.apply()
        configureGameCell()
        applyLocalization()
        applyFonts()
    }
    
    private func configureGameCell() {
        let cell = Bundle.main.loadNibNamed(GameCell.identifier, owner: self, options: nil)?[0] as! GameCell
        let cellContentView = cell.contentView
        gameView.addSubview(cellContentView)
        
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: cellContentView.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor)
        ])
        
        cell.update(with: game, asView: true)
    }
    
    private func applyLocalization() {
        titleLabel.text = NSLocalizedString("confirmation-title", comment: "")
        messageLabel.text = NSLocalizedString("confirmation-message", comment: "")
        betLabel.text = NSLocalizedString("confirmation-bet", comment: "")
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        
        let betText = String(format: NSLocalizedString("confirmation-bet-text", comment: ""), game.homeTeam?.name ?? NSLocalizedString("confirmation-home-team", comment: ""))
        betTextLabel.text = betText
    }
    
    private func applyFonts() {
        titleLabel.font = UIFont.secondaryFont(pointSize: Constants.titleFontSize, weight: .black)
        messageLabel.font = UIFont.secondaryFont(pointSize: Constants.messageFontSize, weight: .medium)
        betLabel.font = UIFont.secondaryFont(pointSize: Constants.betFontSize, weight: .bold)
        okButton.titleLabel?.font = UIFont.primaryFont(pointSize: Constants.buttonFontSize, weight: .heavy)
    }
    
    private func setRandomImage() {
        
        let rand = Int.random(in: 1...3)
        let imageName = "victory\(rand)"
        guard let image = UIImage(named: imageName) else {
            os_log(.error, "Error: Victory image named '%@' was not found.", imageName)
            return
        }
        
        celebrationImage.image = image
    }
    
    private func logAnalytics() {
        AnalyticsManager.logScreenView(screenName: "FullScreenCelebrationViewController")
    }
    
    // MARK: - IBActions
    
    @IBAction private func close() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK: - Extension: Infinite Animation

extension FullScreenCelebrationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag {
            gradientLayer.startAnimation()
        }
        
    }
}

