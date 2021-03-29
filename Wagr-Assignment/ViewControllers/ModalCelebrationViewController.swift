//
//  ModalCelebrationViewController.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import UIKit
import os.log

class ModalCelebrationViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var celebrationImage: UIImageView!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var backgroundView: UIView!
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let titleFontSize: CGFloat = 24
        static let messageFontSize: CGFloat = 16
        static let buttonFontSize: CGFloat = 20
    }
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: "ModalCelebrationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private lazy var gradientLayer: AnimatedGradientLayer = {
        let layer = AnimatedGradientLayer(host: self.backgroundView)

        return layer
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        logAnalytics()
        setRandomImage()
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
        applyLocalization()
        applyFonts()
    }
    
    private func applyLocalization() {
        titleLabel.text = NSLocalizedString("confirmation-modal-title", comment: "")
        messageLabel.text = NSLocalizedString("confirmation-modal-message", comment: "")
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
    }
    
    private func applyFonts() {
        titleLabel.font = UIFont.secondaryFont(pointSize: Constants.titleFontSize, weight: .black)
        messageLabel.font = UIFont.secondaryFont(pointSize: Constants.messageFontSize, weight: .medium)
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
        AnalyticsManager.logScreenView(screenName: "ModalCelebrationViewController")
    }
    
    // MARK: - IBActions
    
    @IBAction private func close() {
        dismiss(animated: true)
    }

}

// MARK: - Extension: Infinite Animation

extension ModalCelebrationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag {
            gradientLayer.startAnimation()
        }
        
    }
}
