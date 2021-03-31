//
//  TeamViewModel.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import Foundation

class TeamViewModel {
    
    // MARK: - Private Properties
    
    private let team: Team
    
    // MARK: - Initializers
    
    init(_ team: Team) {
        self.team = team
    }
    
    // MARK: - Computed Properties
    
    lazy var nameWithNoCity: String = {
        return team.name.replacingOccurrences(of: team.city, with: "").trimmingCharacters(in: .whitespacesAndNewlines)
    }()
    
    lazy var eplName: String = {
        return team.name.replacingOccurrences(of: "FC", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
    }()
    
}
