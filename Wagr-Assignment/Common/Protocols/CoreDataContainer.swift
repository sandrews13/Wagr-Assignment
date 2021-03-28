//
//  CoreDataManager.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import CoreData

protocol CoreDataContainer {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}
