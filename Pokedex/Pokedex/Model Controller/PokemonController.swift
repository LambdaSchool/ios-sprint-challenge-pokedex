//
//  PokemonController.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class PokemonController {
    
    var pokedex: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func fetchPokemon(search: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        
        var allPokemonURL = baseURL.appendingPathComponent("pokemon")
        allPokemonURL.appendPathComponent(search)
        
        
        URLSession.shared.dataTask(with: allPokemonURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(NSError(), nil)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(nil, pokemon)
            } catch {
                NSLog("Error decoding: \(error)")
                completion(error, nil)
                return
            }
        }.resume()
    }
    
    func savePokemon(_ pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func fetchImageFor(pokemon: Pokemon, completion: @escaping (Error?, Pokemon?) -> Void ){
        guard let requestURL = URL(string: pokemon.sprites.frontDefault) else {
            NSLog("Error creating URL")
            completion(NSError(), nil)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemon Image: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            
            pokemon.imageData = data
            completion(nil, pokemon)
            return
            
            }.resume()
    }
}
