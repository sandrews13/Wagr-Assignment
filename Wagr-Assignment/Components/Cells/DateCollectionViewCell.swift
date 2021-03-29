//
//  DateCollectionViewCell.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "DateCollectionViewCell"
    
    // MARK: - Constants
    
    private enum Constants {
        static let pointSize:CGFloat = 16
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var highlightedView: UIView!
    
    // MARK: - Internal Functions
    
    func update(text: String, active: Bool) {
        textLabel.text = text
        textLabel.font = active ? UIFont.quicksandMedium(pointSize: Constants.pointSize) : UIFont.quicksandRegular(pointSize: Constants.pointSize)
        highlightedView.isHidden = !active
    }

}
