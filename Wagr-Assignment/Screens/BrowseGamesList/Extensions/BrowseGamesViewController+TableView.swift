//
//  BrowseGamesViewController+TableView.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-30.
//

import UIKit
import os.log

// MARK: - TableView Delegate/DataSource

extension BrowseGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isFirstSection = (indexPath.section == 0)
        guard indexPath.row > 0 || isFirstSection else {
            return headerCell(for: indexPath.section)
        }
        let row = indexPath.row - (isFirstSection ? 0 : 1)
        guard let gamesOnDay = gameSorter.sortedGames[indexPath.section] else {
            return UITableViewCell()
        }
        
        let game = gamesOnDay[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(with: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let games = gameSorter.sortedGames[section] else {
            return 0
        }
        let shouldAddHeadingCell = (section > 0)
        return games.count + (shouldAddHeadingCell ? 1 : 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameSorter.sortedGames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section == 0 ? indexPath.row : (indexPath.row - 1)
        guard let game = gameSorter.sortedGames[indexPath.section]?[index] else {
            os_log(.error, "Error: Selected game returned nil")
            return
        }
        let celebrationActionSheet = UIAlertController.celebrationActionSheet(host: self, game: game)
        present(celebrationActionSheet, animated: true)
    }
    
    private func headerCell(for section: Int) -> UITableViewCell {
        let header = gamesView.tableView.dequeueReusableCell(withIdentifier: DateHeader.identifier) as! DateHeader
        header.update(title: Date.stringforDaysInFuture(section))
        
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == gamesView.tableView else {
            return
        }
        var yOffset = (-1)*scrollView.contentOffset.y
        if yOffset < 0 {
            yOffset = 0
        }
        gamesView.collectionViewTop.constant = yOffset
        
        if gamesView.tableView.panGestureRecognizer.state == .possible, changingSection {
            changingSection = false
            return
        }
        
        if let visibleIndex = gamesView.tableView.indexPathsForVisibleRows?.first {
            if visibleIndex.section != activeSection {
                activeSection = visibleIndex.section
                reloadCollectionView()
            }
        }
    }
    
}
