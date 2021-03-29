//
//  GameViewModel.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import Foundation

class GameViewModel {
    
    // MARK: - Private Properties
    
    private let game: Game
    
    // MARK: - Constants
    
    private enum Constants {
        static let premierLeagueFull = "ENGLISH_PREMIER_LEAGUE"
        static let premierLeagueShort = "EPL"
    }
    
    // MARK: - Initializers
    
    init(_ game: Game) {
        self.game = game
    }
    
    // MARK: - Computed Properties
    
    lazy var homeSpread: String = {
        guard var spread = game.spread else {
            return NSLocalizedString("game-cell-no-spread", comment: "")
        }
        
        if spread == "0" {
            return spread
        }
        
        if !spread.hasPrefix("-") {
            spread = "+" + spread
        }
        
        return "\(spread)"
    }()
    
    lazy var awaySpread: String = {
        guard var spread = game.spread else {
            return NSLocalizedString("game-cell-no-spread", comment: "")
        }
        
        if spread == "0" {
            return spread
        }
        
        if spread.hasPrefix("-") {
            spread = spread.replacingOccurrences(of: "-", with: "+")
        } else {
            spread = "-" + spread
        }
        
        return "\(spread)"
    }()
    
    lazy var showCity: Bool = {
        return game.league != Constants.premierLeagueFull
    }()
    
    lazy var league: String = {
        if game.league != Constants.premierLeagueFull {
            return game.league
        } else {
            return Constants.premierLeagueShort
        }
    }()
    
}
