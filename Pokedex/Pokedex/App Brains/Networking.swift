//
//  Networking.swift
//  Pokedex
//
//  Created by Shawn James on 4/10/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import Foundation

class Networking {
   
    // MARK: - URL's
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: - Methods
    
    func fetchPokemonByName(pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        
        let fetchPokemonURL = baseURL.appendingPathComponent("\(pokemon.lowercased())")
        
        var request = URLRequest(url: fetchPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving Pokemon data. \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data to decode")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokeData = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokeData))
            } catch {
                NSLog("Error decoding Pokemon object: \(error)")
                completion(.failure(.badData))
                return
            }
        }.resume()
    }
    
    
// MARK: - Helper Enums
    
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case otherError
        case noData
        case badData
    }
    
    
    
}
