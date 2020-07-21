//
//  PokemonDataController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation
import UIKit

class PokemonDataController {
    
    //Properties
    let pokemonBool : Bool = UserDefaults.standard.bool(forKey: .pokemonIntializedKey)
    var pokemonArray : [Pokemon] = []
    var pokemonURL : URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("Pokemon.plist")
    }
    
    init() {
        if pokemonBool == false {
            UserDefaults.standard.set(true, forKey: .pokemonIntializedKey)
            print("created \(pokemonBool)")
        } else {
            print("loaded \(pokemonBool)")
        }
    }
    
    // Persistence Functions
    func createData() {
        saveToPersistenceStore()
    }
    
    func saveToPersistenceStore() {
        guard let url = pokemonURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonArray)
            try data.write(to: url)
            
        } catch {
            print("Not able to encode the data")
        }
    }
    
    func loadFromPersistenceStore() {
        let fm = FileManager.default
        guard let url = pokemonURL, fm.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            pokemonArray = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Not able to decode the data")
        }
    }
    
    func removePokemon(pokemon: Pokemon) {
        guard let pokemonIndex = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: pokemonIndex)
        saveToPersistenceStore()
    }
    
    // Helper functions to get the ability/type strings out of the array
    func getAbilitiesString(pokemon: Pokemon) -> String{
        var string = "Abilities: "
        for ability in pokemon.pokemonAbilities {
            if ability == pokemon.pokemonAbilities.last || ability == pokemon.pokemonAbilities.first {
                string += "\(ability)"
            }
            string += ", \(ability)"
        }
        
        return string
    }
    
    func getTypesString(pokemon: Pokemon) -> String {
        
        var string = "Types: "
        if pokemon.types.count == 1 {
            if let pokemonFirst = pokemon.types.first {
               return "Type: \(pokemonFirst)"
            }
             }
        else {
        for type in pokemon.types {
            if type == pokemon.types.last || type == pokemon.types.first {
                string += "\(type)"
            }
            string += ", \(type)"
        }
    }
        return string
}
}

extension String {
    static let pokemonIntializedKey = "pokemonInitializedKey"
}
