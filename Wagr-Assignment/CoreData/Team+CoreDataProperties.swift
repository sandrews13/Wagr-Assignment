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

    @NSManaged public var city: String?
    @NSManaged public var id: Int32
    @NSManaged public var key: String?
    @NSManaged public var name: String?
    @NSManaged public var primaryColor: String?
    @NSManaged public var secondaryColor: String?
    @NSManaged public var homeGames: Game?
    @NSManaged public var awayGames: Game?

}

extension Team : Identifiable {

}
