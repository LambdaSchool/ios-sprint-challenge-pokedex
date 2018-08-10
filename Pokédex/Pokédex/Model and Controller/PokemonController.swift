//
//  PokemonController.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class PokemonController: Codable {
    
    var pokemons: [Pokemon] = []
    static var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    
    // MARK: - CRUD
    
    func create(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    
    // MARK: - Networking
    
    func get(nameOrID: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        
        let url = PokemonController.baseURL.appendingPathComponent(nameOrID)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            let pokemon: Pokemon
            
            if let error = error {
                NSLog("Error getting data: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(error, nil)
                return
            }
            
            do {
                pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            } catch {
                NSLog("")
                completion(error, nil)
                return
            }
            
            completion(nil, pokemon)
        }.resume()
    }
}
