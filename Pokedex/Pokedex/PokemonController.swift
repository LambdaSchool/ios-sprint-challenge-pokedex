//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jordan Davis on 5/24/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func delete(pokemon: Pokemon) {
        guard let pokemonToDelete = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: pokemonToDelete)
        saveToPersistentStore()
    }
    
    func save(pokemon: Pokemon) {
        pokemons.append(pokemon)
        saveToPersistentStore()
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchPokemon(with name: String, completion: @escaping(Pokemon?, Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(name)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(NSError())")
                completion(nil, NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding the data: \(error)")
                return
            }
            }.resume()
        
    }
    
    func fetchSprite(with pokemon: Pokemon, completion: @escaping(UIImage?, Error?) -> Void) {
        let url = URL(string: pokemon.sprites.imageURL)!
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from the data task")
                return
            }
            
            let image = UIImage(data: data)
            completion(image, nil)
            }.resume()
    }
    
    //MARK: - Persistence
    
    func saveToPersistentStore() {
        guard let url = persistenceURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("error with property list encoder: \(error)")
            return
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistenceURL, fileManager.fileExists(atPath: url.path) else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let returnedPokemon = try decoder.decode([Pokemon].self, from: data)
            pokemons = returnedPokemon
        } catch {
            print("Error with propertylistdecoder: \(error)")
            return
        }
    }
    
    //MARK: - Properties
    
    var pokemons = [Pokemon]()
    
    var persistenceURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = documentDirectory.appendingPathComponent("pokemon.plist")
        return fileName
    }
}
