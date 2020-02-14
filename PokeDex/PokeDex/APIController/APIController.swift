//
//  APIController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class APIController{
    
    // MARK: - Properties
    
    private let baseURL = URL(string: APIKeys.baserURL)!
    
    // MARK: -Methods
    
    func searchForPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkErrors.errors>) -> ()){
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            completion(.failure(.badURL))
            NSLog("Request URL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = APIKeys.HTTPMethods.get.rawValue
        
       URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(.otherError))
                NSLog("Error receiving Pokemon data: \(error)")
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let newPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(newPokemon))
            } catch {
            }
        }.resume()
    }
}
