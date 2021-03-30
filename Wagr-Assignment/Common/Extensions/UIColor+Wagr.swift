//
//  UIColor+Wagr.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import UIKit

// Colors specific to Wagr's theme
extension UIColor {
    
    // Force unwrap, we want to crash if these colours aren't in the bundle; something is wrong
    static let foreground = UIColor(named: "foregroundColour")!
    static let background = UIColor(named: "backgroundColour")!
    
    static let brandForeground = UIColor(named: "brandForeground")!
    static let brandBackground = UIColor(named: "brandBackground")!
    
    static let brandedText = UIColor(named: "brandedTextColour")!
    
    static let gradient1 = UIColor(named: "gradient1")!
    static let gradient2 = UIColor(named: "gradient2")!
    
    static let darkBrandParticle = UIColor(named: "darkBrandParticle")!
    static let blueParticle = UIColor(named: "blueParticle")!
    static let redParticle = UIColor(named: "redParticle")!
    
}
