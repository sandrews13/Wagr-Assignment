//
//  Team+CoreDataClass.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//
//

import Foundation
import CoreData
import os.log

@objc(Team)
public class Team: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case id = "teamId"
        case key = "teamKey"
        case name = "teamName"
        case primaryColor = "primaryColor"
        case secondaryColor = "secondaryColor"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Team", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        let city = try container.decode(String.self, forKey: .city)
        self.city = cleanCity(city)
        self.key = try container.decode(String.self, forKey: .key)
        self.name = try container.decode(String.self, forKey: .name)
        self.primaryColor = try container.decode(String.self, forKey: .primaryColor)
        self.secondaryColor = try container.decode(String.self, forKey: .secondaryColor)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.primaryColor, forKey: .primaryColor)
        try container.encode(self.secondaryColor, forKey: .secondaryColor)
        
    }
    
    private func cleanCity(_ city: String) -> String {
        let parts = city.split(separator: ",")
        guard let cityName = parts.first else {
            return city
        }
        return String(cityName)
    }
    
}

extension Team {
    
    static func fetchTeam(with id: Int32, context: NSManagedObjectContext) -> Team? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            guard let fetchedTeams = try context.fetch(fetchRequest) as? [Team], fetchedTeams.count > 0 else {
                return nil
            }
            
            return fetchedTeams.first
        } catch {
            os_log(.error, "Team with id %d not found", id)
        }
        return nil
    }
}
