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
    
    init() {
        loadFromPersistentStore()
    }
    
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
        saveToPersistentStore()
    }
    
    func delete(pokemon: Pokemon) {
        guard let pokemonIndex = pokemonList.firstIndex(of: pokemon) else { return }
        pokemonList.remove(at: pokemonIndex)
        saveToPersistentStore()
    }
    
    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let pokemon = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return pokemon.appendingPathComponent("pokemonList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonList)
            try data.write(to: url)
        } catch {
            print("Error saving pokemon data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.pokemonList = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Error loading pokemon data: \(error)")
        }
    }
}
