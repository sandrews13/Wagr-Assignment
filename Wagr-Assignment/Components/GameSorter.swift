//
//  GameSorter.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-28.
//

import Foundation

// Sorts a list of games into sections based on their dates
class GameSorter {
    
    // MARK: - Internal Properties
    
    // Stores sorted games as [days in the future -> games on that day]
    var sortedGames = [Int: [Game]]()
    
    // MARK: - Private Properties
    
    private let allGames: [Game]
    
    private var largestDayDifference = 0
    
    // MARK: - Initializers
    
    init(games: [Game]) {
        allGames = games
        sort()
        addEmptyDays()
    }
    
    // MARK: - Private Methods
    
    private func sort() {
        
        let rightNow = Date.rightNow // Fake current date (Jan 21, 2021) since all games from API are the past
        
        for game in allGames {
            
            // 1. Make sure game is in the future
            if game.date < rightNow {
                continue
            }
            
            // 2. Sort into buckets
            if let daysUntilGame = Calendar.current.numberOfDaysBetween(rightNow, and: game.date) {
                
                if var games = sortedGames[daysUntilGame] {
                    games.append(game)
                    sortedGames[daysUntilGame] = games
                } else {
                    sortedGames[daysUntilGame] = [game]
                }
                
                if largestDayDifference < daysUntilGame {
                    largestDayDifference = daysUntilGame
                }
            }
            
        }
    }
    
    private func addEmptyDays() {
        
        for i in 0...largestDayDifference {
            if sortedGames[i] == nil {
                sortedGames[i] = []
            }
        }
    }
    
}
