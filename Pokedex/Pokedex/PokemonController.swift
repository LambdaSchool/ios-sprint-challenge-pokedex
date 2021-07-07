//
//  PokemonController.swift
//  Pokedex
//
//  Created by Daniela Parra on 9/14/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class PokemonController {
    // MARK: - CRUD
    
    func savePokemon(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        
        pokedex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        
        guard let index = pokedex.index(of: pokemon) else { return }
        
        pokedex.remove(at: index)
    }
    
    // MARK: - Networking
    
    func searchPokemon(name: String, completion: @escaping (Error?) -> Void) {
        
        var requestURL = baseURL.appendingPathComponent("api")
        requestURL.appendPathComponent("v2")
        requestURL.appendPathComponent("pokemon")
        requestURL.appendPathComponent(name)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemonResults = try jsonDecoder.decode(Pokemon.self, from: data)
                print(pokemonResults)
                
                self.pokemon = pokemonResults
                
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
    let baseURL = URL(string: "https://pokeapi.co/")!
    
    var pokedex: [Pokemon] = []
    
}
