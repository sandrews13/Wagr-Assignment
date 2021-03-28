//
//  Team+CoreDataProperties.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var city: String
    @NSManaged public var id: Int32
    @NSManaged public var key: String
    @NSManaged public var name: String
    @NSManaged public var primaryColor: String
    @NSManaged public var secondaryColor: String
    @NSManaged public var awayGames: NSSet?
    @NSManaged public var homeGames: NSSet?

}

// MARK: Generated accessors for awayGames
extension Team {

    @objc(addAwayGamesObject:)
    @NSManaged public func addToAwayGames(_ value: Game)

    @objc(removeAwayGamesObject:)
    @NSManaged public func removeFromAwayGames(_ value: Game)

    @objc(addAwayGames:)
    @NSManaged public func addToAwayGames(_ values: NSSet)

    @objc(removeAwayGames:)
    @NSManaged public func removeFromAwayGames(_ values: NSSet)

}

// MARK: Generated accessors for homeGames
extension Team {

    @objc(addHomeGamesObject:)
    @NSManaged public func addToHomeGames(_ value: Game)

    @objc(removeHomeGamesObject:)
    @NSManaged public func removeFromHomeGames(_ value: Game)

    @objc(addHomeGames:)
    @NSManaged public func addToHomeGames(_ values: NSSet)

    @objc(removeHomeGames:)
    @NSManaged public func removeFromHomeGames(_ values: NSSet)

}

extension Team : Identifiable {

}
