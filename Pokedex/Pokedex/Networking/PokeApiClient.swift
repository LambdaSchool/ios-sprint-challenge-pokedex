//
//  PokeApiClient.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case clientError(Error)
    case noData
    case badData
}

private let baseURL = URL(string: "https://pokeapi.co/api/v2")!

class PokeApiClient {
    
    // fetch all names
    //func fetchAllPokemonNames
    
    // fetch pokemon by name
    func fetchPokemon(withName name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        var pokemonURL = baseURL.appendingPathComponent("pokemon")
        pokemonURL.appendPathComponent(name.lowercased())
        
        URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(.failure(.clientError(error)))
                return
            }
            
            guard let data = data else {
                NSLog("No data when trying to fetch pokemon")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Unable to decode JSON into pokemon: \(error)")
                completion(.failure(.badData))
            }
        }.resume()
    }
    
    // fetch image for url string
}
