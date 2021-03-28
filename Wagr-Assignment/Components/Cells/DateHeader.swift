//
//  DateHeader.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import UIKit

class DateHeader: UITableViewHeaderFooterView {

    // MARK: - Static Properties
    
    static var identifier = "DateHeader"
    
    // MARK: - Constants
    
    private enum Constants {
        static let fontSize: CGFloat = 24
        
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 16
    }
    
    // MARK: - Private Properties
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.quicksandRegular(pointSize: Constants.fontSize)
        label.backgroundColor = .clear
        
        return label
    }()
    
    // MARK: - Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundView?.backgroundColor = .background
        contentView.backgroundColor = .background
        contentView.addSubview(titleLabel)
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalSpace),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpace),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalSpace),
        ])
    }
    
    @available(iOS 14.0, *)
    override func updateConfiguration(using state: UIViewConfigurationState) {
        backgroundConfiguration = UIBackgroundConfiguration.clear()
    }

}
