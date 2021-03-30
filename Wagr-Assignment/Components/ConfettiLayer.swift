//
//  ConfettiLayer.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-30.
//

import UIKit

class ConfettiLayer: CAEmitterLayer {
    
    // MARK: - Private Properties
    
    private let host: UIView
    private let colours = [
        UIColor.brandForeground.cgColor,
        UIColor.darkBrandParticle.cgColor,
        UIColor.blueParticle.cgColor,
        UIColor.redParticle.cgColor
    ]
    private var currentColour = 0
    
    // MARK: - Initializers
    
    init(host: UIView) {
        self.host = host
        super.init()
        configureEmitter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func apply() {
        host.layer.insertSublayer(self, at: 1)
    }
    
    // MARK: - Private Methods
    
    private func configureEmitter() {
        emitterPosition = CGPoint(x: host.frame.size.width / 2, y: -10)
        emitterShape = CAEmitterLayerEmitterShape.line
        emitterSize = CGSize(width: host.frame.size.width, height: 2.0)
        emitterCells = generateEmitterCells()
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for _ in 0..<4 {
            let cell = CAEmitterCell()
            cell.birthRate = 1.0
            cell.lifetime = 50.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat.random(in: 20...40)
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.2
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = confettiColour()
            cell.contents = UIImage.finger?.cgImage
            cell.scaleRange = 0.25
            cell.scale = 0.1
            cells.append(cell)
        }
        return cells
    }
    
    private func confettiColour() -> CGColor {
        currentColour += 1
        if currentColour >= colours.count {
            currentColour = 0
        }
        
        return colours[currentColour]
    }
}
