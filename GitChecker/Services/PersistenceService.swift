//
//  PersistenceService.swift
//  GitChecker
//
//  Created by Данила Рахманов on 05.05.2024.
//

import Foundation

enum PersistenceAvtionType {
    case add, remove
}

final class PersistenceService {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func isFavourite(favourite: Follower, completed: @escaping (Bool) -> Void) {
        retrieveFavourites { (favourites, errorMessage) in
            guard var favourites = favourites else {
                completed(false)
                return
            }
            
            guard !favourites.contains(favourite) else {
                completed(true)
                return
            }
            
            completed(false)
            return
        }
    }
    
    static func updateWith(
        favourite: Follower,
        actionType: PersistenceAvtionType,
        completed: @escaping (String?) -> Void
    ) {
        retrieveFavourites { (favourites, errorMessage) in
            guard var favourites = favourites else {
                completed(errorMessage!)
                return
            }
            
            switch actionType {
            case .add:
                guard !favourites.contains(favourite) else {
                    completed("dublicate")
                    return
                }
                favourites.append(favourite)
            case .remove:
                favourites.removeAll { $0.login == favourite.login }
            }
            
            completed(save(favourites: favourites))
        }
    }
    
    static func retrieveFavourites(completion: @escaping ([Follower]?, String?) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completion([], nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)

            completion(favourites, nil)
        } catch {
            completion(nil, "Data received from server is invalid. Please try again.")
        }
    }
    
    static func save(favourites: [Follower]) -> String? {
        do {
            let encoder = JSONEncoder()
            let favourites = try encoder.encode(favourites)
            
            defaults.set(favourites, forKey: Keys.favourites)
            return nil
        } catch {
            return "Unable to encode favourites."
        }
    }
}
