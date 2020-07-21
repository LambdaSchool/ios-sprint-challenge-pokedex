//
//  PokemonController.swift
//  Pokedex
//
//  Created by Norlan Tibanear on 7/17/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noData
    case noImage
    case tryAgain
    case decodeFailed
}

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
 
    var savedPokemon: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
//    private lazy var pokemonURL = baseURL.appendingPathComponent("pokemon/")
 
    func fetchPokemon(with pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let fetchPokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemon.lowercased())")
        
        var request = URLRequest(url: fetchPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Could not decode pokemon \(pokemon)")
                completion(.failure(.decodeFailed))
                return
            }
        } .resume()
    }
    
    func fetchSprite(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.noImage))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
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
        let pokemon = Pokemon(name: pokemon.name, id: pokemon.id, ability: pokemon.ability, types: pokemon.types, sprites: pokemon.sprites)
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
    func removePokemon(pokemon: Pokemon) {
        guard let pokemonIndex = savedPokemon.firstIndex(of: pokemon) else { return }
        savedPokemon.remove(at: pokemonIndex)
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
            let data = try Data(contentsOf: pokemonURL)
            let decoder = PropertyListDecoder()
            savedPokemon = try decoder.decode([Pokemon].self, from: data)
        } catch {
            NSLog("Error loading pokemon: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let pokemonURL = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(savedPokemon)
            try data.write(to: pokemonURL)
        } catch {
            NSLog("Error saving pokemon: \(error)")
        }
    }
    
}
