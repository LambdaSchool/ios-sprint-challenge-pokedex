//
//  PokemonController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 14/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case serverError(Error)
    case noData
    case badDecode
}

class PokemonController {
    
    var pokemonList: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func findPokemon(called name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let requestURL = baseURL
        .appendingPathComponent("pokemon")
            .appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error requesting pokemon data: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let data = data else {
                NSLog("Error with the pokemon data")
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding pokemon data: \(error)")
                completion(.failure(.badDecode))
                return
            }
        }.resume()
    }
    
    func save(pokemon: Pokemon) {
        let pokemon = Pokemon(name: pokemon.name, id: pokemon.id, abilities: pokemon.abilities, types: pokemon.types, sprites: pokemon.sprites)
        pokemonList.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let pokemonIndex = pokemonList.firstIndex(of: pokemon) else { return }
        pokemonList.remove(at: pokemonIndex)
    }
}
