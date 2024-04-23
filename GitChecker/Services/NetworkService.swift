//
//  NetworkService.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    // MARK: - get followers
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username is invalid. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, "Unable to complete search. Check your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completion(nil, "Data received from server is invalid. Please try again.")
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)

                completion(followers, nil)
            } catch {
                completion(nil, "Data received from server is invalid. Please try again.")
            }
        }
        
        task.resume()
    }
}
