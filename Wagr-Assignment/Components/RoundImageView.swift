//
//  RoundImageView.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-29.
//

import UIKit

class RoundImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2.0
    }

}
