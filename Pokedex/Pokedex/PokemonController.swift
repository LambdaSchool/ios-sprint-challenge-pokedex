//
//  PokemonController.swift
//  Pokedex
//
//  Created by Moin Uddin on 9/14/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

class PokemonController {
    
    func createPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func removePokemon(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetchPokemon(nameOrId: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        let pokemonURL = requestURL.appendingPathComponent(nameOrId)
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error fetching pokemon \(error)")
                completion(error, nil)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError(), nil)
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(nil, pokemon)
            } catch {
                NSLog("Error getting data: \(error)")
                completion(error, nil)
            }
            }.resume()
    }
    
    
    
    var baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemons: [Pokemon] = []
}
