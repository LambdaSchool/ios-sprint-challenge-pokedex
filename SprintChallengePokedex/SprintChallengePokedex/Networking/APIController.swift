//
//  APIController.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit


/// Enum to describe the various networking errors
enum NetworkError: Error {
    case invalidURL
    case otherError
    case invalidRequest
    case noData
    case noDecode
}


/// Enum for the various HTTPMethods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIController {
    
    let baseURL = "https://pokeapi.co/api/v2"
    
    
    /// Function utilized to make a network call and retrieve Pokemon based on the search term passed in
    /// - Parameters:
    ///   - term: The term searched for
    ///   - completion: Callback informing the caller that the networking has completed
    func searchForPokemon(with term: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        guard let url = URL(string: baseURL)?.appendingPathComponent("pokemon").appendingPathComponent("\(term)") else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.invalidRequest))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let jsonData = try decoder.decode(Pokemon.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            } catch let decodeError {
                print("Error decoding Pokemon objects: \(decodeError.localizedDescription)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    
    /// Function utilized to make a network call and retrieve the image for the selected Pokemon
    /// - Parameters:
    ///   - urlString: The url for the image
    ///   - completion: Callback informing the caller that the networking has completed
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
}
