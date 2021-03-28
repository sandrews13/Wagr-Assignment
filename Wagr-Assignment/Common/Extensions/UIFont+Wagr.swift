//
//  UIFont+Wagr.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import UIKit
import os.log

extension UIFont {
    
    static func quicksandRegular(pointSize: CGFloat) -> UIFont {
        
        guard let font = UIFont(name: "Quicksand-Regular", size: pointSize) else {
            os_log(.error, "Error: Quicksand-Regular font is missing.")
            return UIFont.systemFont(ofSize: pointSize, weight: .regular)
        }
        
        return font
    }
}
