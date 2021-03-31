//
//  Game+CoreDataClass.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//
//

import Foundation
import CoreData

@objc(Game)
public class Game: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case date = "gameDatetime"
        case id = "gameId"
        case league = "league"
        case status = "gameStatus"
        case spread = "spread"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
    }

    public required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int32.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        league = try container.decode(String.self, forKey: .league)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        spread = try container.decodeIfPresent(String.self, forKey: .spread)
        homeTeam = try fetchTeam(with: container, key: .homeTeam, context: context)
        awayTeam = try fetchTeam(with: container, key: .awayTeam, context: context)
    }
    
    private func fetchTeam(with container: KeyedDecodingContainer<CodingKeys>, key: CodingKeys, context: NSManagedObjectContext) throws -> Team? {
        let teamId = try container.decode(TeamId.self, forKey: key)
        
        if let coreDataTeam = Team.fetchTeam(with: teamId.id, context: context) {
            return coreDataTeam
        } else {
            return try container.decodeIfPresent(Team.self, forKey: key)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(league, forKey: .league)
        try container.encode(status, forKey: .status)
        try container.encode(spread, forKey: .spread)
        try container.encode(awayTeam, forKey: .awayTeam)
        try container.encode(homeTeam, forKey: .homeTeam)
    }
}
