//
//  BrowseGamesViewController+CollectionView.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-30.
//

import UIKit

// MARK: - CollectionView

extension BrowseGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
        cell.update(text: Date.stringforDaysInFuture(indexPath.row), active: activeSection == indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameSorter.sortedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activeSection = indexPath.row
        reloadCollectionView()
        changingSection = true
        gamesView.scrollTableView(to: activeSection)
    }
    
    func reloadCollectionView() {
        let indexPath = IndexPath(item: activeSection, section: 0)
        gamesView.collectionView.reloadSections(IndexSet(integer: 0))
        DispatchQueue.main.async {
            self.gamesView.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
}

