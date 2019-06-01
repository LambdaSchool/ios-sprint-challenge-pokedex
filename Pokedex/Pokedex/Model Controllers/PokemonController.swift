//
//  PokemonController.swift
//  Pokedex
//
//  Created by Michael Stoffer on 6/1/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noEncode
}

class PokemonController {
    private (set) var pokemons: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func searchForPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, result, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else { NSLog("No data returned from data task"); completion(.failure(.badData)); return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func savePokemon(with pokemon: Pokemon) {
        self.pokemons.append(pokemon)
    }
    
    func delete(with pokemon: Pokemon) {
        guard let index = self.pokemons.firstIndex(of: pokemon) else { return }
        self.pokemons.remove(at: index)        
    }
}
