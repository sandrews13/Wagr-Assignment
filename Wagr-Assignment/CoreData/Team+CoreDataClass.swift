//
//  Team+CoreDataClass.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//
//

import Foundation
import CoreData

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
        
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Team", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.primaryColor = try container.decodeIfPresent(String.self, forKey: .primaryColor)
        self.secondaryColor = try container.decodeIfPresent(String.self, forKey: .secondaryColor)
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
    
}
