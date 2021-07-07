//
//  PokemonController.swift
//  Pokedex
//
//  Created by Michael on 1/17/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badRequest
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    
    var savedPokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    func getPokemonDetails(pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let getPokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemon)")
        
        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("This is the returned response: \(response)")
                completion(.failure(.badRequest))
            }
            
            if let error = error {
                NSLog("Error receiving pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func savePokemon(name: String, id: Int, abilities: [AbilityParent], type: [TypeParent], sprites: Sprites) {
        let newSavedPokemon = Pokemon(id: id, name: name, abilities: abilities, sprites: sprites, types: type)
        savedPokemon.append(newSavedPokemon)
        saveToPersistentStore()
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let pokemonToRemove = savedPokemon.firstIndex(of: pokemon) else { return }
        savedPokemon.remove(at: pokemonToRemove)
        saveToPersistentStore()
    }
    
    var pokemonURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let pokemonURL = documentDir.appendingPathComponent("Pokemon.plist")
        
        return pokemonURL
    }
    
    func saveToPersistentStore() {
        guard let pokemonURL = pokemonURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let pokemonData = try encoder.encode(savedPokemon)
            
            try pokemonData.write(to: pokemonURL)
        } catch {
            print("Error saving data: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let pokemonURL = pokemonURL else { return }
            
            let pokemonData = try Data(contentsOf: pokemonURL)
            
            let decoder = PropertyListDecoder()
            
            let pokemonArray = try decoder.decode([Pokemon].self, from: pokemonData)
            
            self.savedPokemon = pokemonArray
        } catch {
            print("Error loading data from plist: \(error).")
        }
    }
}
