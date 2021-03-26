//
//  Game+CoreDataProperties.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int32
    @NSManaged public var league: String?
    @NSManaged public var status: String?
    @NSManaged public var spread: String?
    @NSManaged public var awayTeam: Team?
    @NSManaged public var homeTeam: Team?

}

extension Game : Identifiable {

}
