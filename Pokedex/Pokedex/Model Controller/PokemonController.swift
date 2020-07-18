//
//  PokemonController.swift
//  Pokedex
//
//  Created by Norlan Tibanear on 7/17/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noData
    case noImageData
    case FailedDecoding
    case noImage
}


class PokemonController {
    
    var allPokemon: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    private lazy var pokemonURL = baseURL.appendingPathComponent("pokemon/")
    
    
    
    func fetchingPokemon(with pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
            }
            
            guard let data = data else {
                print("No Data")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Failed decoding pokemon \(pokemon)")
                completion(.failure(.FailedDecoding))
                return
            }
            
        }.resume()
    } //
    
    
    func fetchingSprite(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else { completion(.failure(.noImage)); return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(.noImage))
                return
            }
            
            guard let imageData = data else {
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: imageData) {
                completion(.success(image))
            } else {
                completion(.failure(.noImage))
                return
            }
        } .resume()
        
    }
    
    
    func savePokemon(pokemon: Pokemon) {
        let newPokemon = Pokemon(name: pokemon.name, id: pokemon.id, abilities: pokemon.abilities, types: pokemon.types, sprites: pokemon.sprites)
        allPokemon.append(newPokemon)
        saveToPersistentStore()
    }
    
    func removePokemon(pokemon: Pokemon) {
        guard let pokemonIndex = allPokemon.firstIndex(of: pokemon) else { return }
        allPokemon.remove(at: pokemonIndex)
        saveToPersistentStore()
    }
    
// Persistence
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("Pokemon.plist")
    }
    
    func loadFromPersistentStore() {
        guard let pokemonURL = persistentFileURL else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: pokemonURL)
            allPokemon = try decoder.decode([Pokemon].self, from: data)
        } catch {
            NSLog("Error loading pokemon: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let pokemonURL = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allPokemon)
            try data.write(to: pokemonURL)
        } catch {
            NSLog("Error saving pokemon: \(error)")
        }
    }
    
    
} //
