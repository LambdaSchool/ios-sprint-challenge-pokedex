//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Vincent Hoang on 5/8/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import os.log

enum NetworkError: Error {
    case failed, noData
}

final class PokemonAPI {
    let baseURL = URL(string: "https://pokeapi.co")
    
    private lazy var jsonDecoder = JSONDecoder()
    
    func searchPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let urlString = "/api/v2/pokemon/\(pokemonName.lowercased())"
        let pokemonURL = URL(string: urlString, relativeTo: baseURL)!
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: pokemonURL) { data, response, error in
            if error != nil {
                completion(.failure(.failed))
                os_log("Failed")
                return
            }
            
            print(response)
            
            guard let data = data else {
                completion(.failure(.noData))
                os_log("no data")
                return
            }
            
            do {
                let pokemon = try self.jsonDecoder.decode(Pokemon.self, from: data)
                os_log("Decoding success")
                completion(.success(pokemon))
            } catch {
                os_log("Decoding error: %@", "\(error)")
                completion(.failure(.failed))
            }
        }
        os_log("Network task called")
        
        task.resume()
    }
    
    
}
