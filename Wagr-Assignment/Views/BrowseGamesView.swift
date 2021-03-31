//
//  BrowseGamesView.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-30.
//

import UIKit

class BrowseGamesView: UIView {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
}

// MARK: - Setup

extension BrowseGamesView {
    
    func configureUI() {
        registerCells()
        tableView.setValue(UIColor.background , forKey: "tableHeaderBackgroundColor")
    }
    
}

// MARK: - Table & Collection View Functions

extension BrowseGamesView {
    
    // MARK: - Shared
    
    func reload() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
        self.loader.stopAnimating()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: DateCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        
        tableView.register(UINib(nibName: GameCell.identifier, bundle: nil), forCellReuseIdentifier: GameCell.identifier)
        tableView.register(DateHeader.self, forCellReuseIdentifier: DateHeader.identifier)
    }
    
    // MARK: - Collection View
    
    func reloadCollectionView(activeSection: Int) {
        let indexPath = IndexPath(item: activeSection, section: 0)
        collectionView.reloadSections(IndexSet(integer: 0))
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    // MARK: - Table View
    
    func scrollTableView(to section: Int) {
        let item = section == 0 ? 0 : 1
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: item, section: section)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
