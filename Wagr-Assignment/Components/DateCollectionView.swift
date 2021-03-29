//
//  DateCollectionView.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import UIKit

class DateCollectionView: UICollectionView {

    private enum Constants {
        static let horizontalInsets: CGFloat = 12
    }
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.horizontalInsets, bottom: 0, right: Constants.horizontalInsets)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
