//
//  NetworkManager.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import Foundation
import CoreData

class NetworkManager {
    
    private enum Constants {
        static let baseUrl = "https://us-central1-wagr-develop.cloudfunctions.net/"
        static let gamesUrl = baseUrl + "code-challenge-mobile-app-games"
    }
    
    static func fetchGames(completion: @escaping (Error?, [Game]?) -> Void) {
        
        guard let url = URL(string: Constants.gamesUrl) else {
            completion(NetworkError.urlError, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(NetworkError.dataError, nil)
                return
            }
            
            let parentContext = CoreDataManager.shared.context
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = parentContext
            context.perform {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .customISO8601
                decoder.userInfo[.context] = context
                
                let decodedGames = try? decoder.decode([Game].self, from: data)
                
                guard let games = decodedGames else {
                    completion(NetworkError.decodingError, nil)
                    return
                }
                
                do {
                    try context.save()
                } catch {
                    print("Error saving context: \(error.localizedDescription)")
                }
                CoreDataManager.shared.saveContext()
                
                completion(nil, games)
            }
        }.resume()
    }
    
}
