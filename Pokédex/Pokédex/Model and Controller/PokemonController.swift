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
    
    // TODO: Fix this
    func get(nameOrID: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        
        let input = nameOrID.lowercased()
        
        let url = PokemonController.baseURL.appendingPathComponent(input)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            var pokemon: Pokemon
            
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
            
            // types
            pokemon.allTypes = ""
            let allTypesArray = pokemon.types.dropLast().compactMap { $0.name }
            for type in allTypesArray {
                // if types is nil, compiler won't call completion...
                guard var types = pokemon.allTypes else { return }
                types += "\(type), "
                pokemon.allTypes = types
            }
            
            guard let types = pokemon.allTypes,
                let lastType = allTypesArray.last else { return }
            
            let allTypes = types + " " + lastType
            
            pokemon.allTypes = allTypes
            
            // abilities
            pokemon.allAbilities = ""
            let allAbilitiesArray = pokemon.abilities.dropLast().compactMap { $0.name }
            for ability in allAbilitiesArray {
                // if types is nil, compiler won't call completion...
                guard var abilities = pokemon.allAbilities else { return }
                abilities += "\(ability), "
                pokemon.allAbilities = abilities
            }
            
            guard let abilities = pokemon.allAbilities,
                let lastAbility = allAbilitiesArray.last else { return }
            
            let allAbilities = abilities + " " + lastAbility
            
            pokemon.allAbilities = allAbilities
            
            completion(nil, pokemon)
        }.resume()
    }
}
