//
//  PokemonController.swift
//  Pokedex
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation

class PokemonController {
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case noData
        case tryAgain
        case networkFailure
    }

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemon: [Pokemon] = []
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.networkFailure))
                return
            }
            
            guard let data = data else {
                print("No data received from fetchPokemon")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        task.resume()
    }
}
