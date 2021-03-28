//
//  Game+Cacheable.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import CoreData

extension Game: Cacheable {
    
    static func fetchAllFromCache() -> [Game]? {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        let sortDate = NSSortDescriptor(key: "date", ascending: true)
        let sortName = NSSortDescriptor(key: "homeTeam.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDate, sortName]
        fetchRequest.returnsObjectsAsFaults = false
        if let fetchedGames = try? CoreDataManager.shared.context.fetch(fetchRequest), !fetchedGames.isEmpty {
            return fetchedGames
        }
        
        return nil
    }
    
}
