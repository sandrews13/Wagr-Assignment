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
        static let pointSize: CGFloat = 18
        static let fontSelected = UIFont.secondaryFont(pointSize: Constants.pointSize, weight: .medium)
        static let fontUnselected = UIFont.secondaryFont(pointSize: Constants.pointSize, weight: .regular)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var highlightedView: UIView!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.font = UIFont.secondaryFont(pointSize: 18, weight: .regular)
    }
    
    // MARK: - Internal Functions
    
    func update(text: String, active: Bool) {
        textLabel.text = text
        textLabel.font = active ? Constants.fontSelected : Constants.fontUnselected
        highlightedView.isHidden = !active
    }

}
