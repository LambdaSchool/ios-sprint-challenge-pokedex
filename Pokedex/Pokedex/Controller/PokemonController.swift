//
//  PokemonController.swift
//  Pokedex
//
//  Created by Claudia Contreras on 3/20/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
    case noImage
}

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - Properties
    var savedPokemon: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("Pokemon.plist")
    }
    
    // MARK: Functions
    
    // Get the Pokemon based on search
    func getPokemon(with pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let getPokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemon.lowercased())")
        
        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Request data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            //Decode the data
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailed))
            }
            
        }.resume()
    }

    func save (pokemon: Pokemon) {
        let pokemon = Pokemon(name: pokemon.name, id: pokemon.id, types: pokemon.types, abilities: pokemon.abilities, sprites: pokemon.sprites)
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
    func delete(pokemon: Pokemon) {
        guard let pokemonIndex = savedPokemon.firstIndex(of: pokemon) else { return }
        savedPokemon.remove(at: pokemonIndex)
        saveToPersistentStore()
    }
    
    //MARK: - SAVE and LOAD
    func saveToPersistentStore() {
        
        //place to store the data
        guard let pokemonListURL = persistentFileURL else { return }
        
        //Need to convert the data to something that can be stored on the phone
        do {
            //Get ready to encode the data
            let encoder = PropertyListEncoder()
            
            //the encoded data
            let pokemonData = try encoder.encode(savedPokemon)
            
            //write to the url
            try pokemonData.write(to: pokemonListURL)
            
        } catch {
            print("Error saving pokemon data: \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {

        do {
            guard let pokemonListURL = persistentFileURL else {return}
            //pull the data from the url
            let pokemonData = try Data(contentsOf: pokemonListURL)
            
            //to decode the data
            let decoder = PropertyListDecoder()
            
            // Decode the data and place in array (we specify what type to decode itself into)
            savedPokemon = try decoder.decode([Pokemon].self, from: pokemonData)
            
        } catch {
            print("error loading data: \(error)")
        }
    }
}
