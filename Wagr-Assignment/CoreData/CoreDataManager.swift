//
//  CoreDataManager.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import CoreData

class CoreDataManager: CoreDataContainer {
    
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Wagr_Assignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // I would normally handle this error in a cleaner way in production, but for dev/poc this is fine for now
                fatalError("Unresolved core data error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        context.mergePolicy = NSOverwriteMergePolicy
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // I would normally handle this error in a cleaner way in production, but for dev/poc this is fine for now
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
