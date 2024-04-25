//
//  NetworkService.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class NetworkService {
    static let shared = NetworkService()
    let cache = NSCache<NSString, UIImage>()
    
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
    
    func getImage(from urlString: String, completion: @escaping (UIImage?, String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, "wrong")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: NSString(string: urlString))
            completion(image, nil)
        }
        
        task.resume()
    }
    
    func getUser(by username: String, completion: @escaping (User?, String?) -> Void) {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username is invalid. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)

                completion(user, nil)
            } catch {
                completion(nil, "Data received from server is invalid. Please try again.")
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from url: String, for imageView: UIImageView) {
        if let image = NetworkService.shared.cache.object(forKey: NSString(string: url)) {
            imageView.image = image
            return
        }
        
        NetworkService.shared.getImage(from: url) { (image, errorMessage) in
            guard let image = image else {
                print(errorMessage!)
                return
            }
                        
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
