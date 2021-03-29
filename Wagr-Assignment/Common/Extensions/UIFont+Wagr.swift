//
//  UIFont+Wagr.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import UIKit
import os.log

extension UIFont {
    
    static func primaryFont(pointSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        
        let baseFont = "Quicksand-"
        var fullFontName = baseFont
        switch weight {
            case .bold, .heavy, .black:
                fullFontName += "Bold"
            case .medium:
                fullFontName += "Medium"
            case .semibold:
                fullFontName += "SemiBold"
            case .light, .thin, .ultraLight:
                fullFontName += "Light"
            default:
                fullFontName += "Regular"
        }
        
        guard let font = UIFont(name: fullFontName, size: pointSize) else {
            os_log(.error, "Error: The %@ font was not found. Attempting to return the base font.", fullFontName)
            return defaultFont(baseName: baseFont, pointSize: pointSize, weight: weight)
        }
        
        return font
    }
    
    static func secondaryFont(pointSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        
        let baseFont = "Roboto-"
        var fullFontName = baseFont
        switch weight {
            case .black:
                fullFontName += "Black"
            case .bold, .heavy:
                fullFontName += "Bold"
            case .medium, .semibold:
                fullFontName += "Medium"
            case .thin, .ultraLight:
                fullFontName += "Thin"
            case .light:
                fullFontName += "Light"
            default:
                fullFontName += "Regular"
        }
        
        guard let font = UIFont(name: fullFontName, size: pointSize) else {
            os_log(.error, "Error: The %@ font was not found. Attempting to return the base font.", fullFontName)
            return defaultFont(baseName: baseFont, pointSize: pointSize, weight: weight)
        }
        
        return font
    }
    
    
    static private func defaultFont(baseName: String, pointSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        guard let font = UIFont(name: "\(baseName)Regular", size: pointSize) else {
            os_log(.error, "Error: The base font %@Regular is missing. Returning system font", baseName)
            return UIFont.systemFont(ofSize: pointSize, weight: weight)
        }
        
        return font
    }
    
}
