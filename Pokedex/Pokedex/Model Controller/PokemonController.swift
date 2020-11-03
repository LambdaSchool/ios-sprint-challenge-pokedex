//
//  PokemonController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/24/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemon: Pokemon?
    var savedPokemon: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
    func searchForPokemon(with pokemonName: String, completion: @escaping (Error?) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonName.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with request: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error: no data returned")
                completion(error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonResult
                completion(nil)
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(error)
            }
        }.resume()
        
    }
    
    func saveToPersistentStore() {
        guard let url = persistentURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(savedPokemon)
            try data.write(to: url)
        } catch {
            print("Error saving pokemon: \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            savedPokemon = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Error loading data from dis: \(error)")
        }
    }
    
    private var persistentURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documents.appendingPathComponent("pokemon.plist")
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "Post"
    case delete = "DELETE"
}
