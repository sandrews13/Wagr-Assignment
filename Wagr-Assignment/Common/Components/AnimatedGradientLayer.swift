//
//  AnimatedGradientLayer.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import UIKit

class AnimatedGradientLayer: CAGradientLayer {

    weak var animationDelegate: CAAnimationDelegate?
    
    private let host: UIView
    private var currentGradient: Int = 0
    
    private let gradientColours = [
        [UIColor.gradient1.cgColor, UIColor.gradient2.cgColor],
        [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor]
    ]
    
    init(host view: UIView) {
        host = view
        super.init()
        
        configureGradient()
    }
    
    override init(layer: Any) {
        host = UIView()
        super.init(layer: layer)
    }
    
    func apply() {
        host.layer.insertSublayer(self, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureGradient() {
        
        frame = host.bounds
        colors = gradientColours[0]
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
        drawsAsynchronously = false

    }
    
    func startAnimation() {
        colors = gradientColours[currentGradient]
        if currentGradient < gradientColours.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 5.0
        gradientChangeAnimation.toValue = gradientColours[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = animationDelegate
        add(gradientChangeAnimation, forKey: "colorChange")
    }
    
}
