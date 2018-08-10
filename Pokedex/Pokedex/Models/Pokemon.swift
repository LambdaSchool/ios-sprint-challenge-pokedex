//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vuk Radosavljevic on 8/10/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [PokemonAbilities]
    let types: [PokemonType]

    struct PokemonAbilities: Codable, Equatable {
        
        var ability: Abilities
        
        
        struct Abilities: Codable, Equatable {
            var name: String
        }
    }
    
    
    struct PokemonType: Codable, Equatable {
        var type: SpecificType
        
        struct SpecificType: Codable, Equatable {
            var name: String
        }
    }
}
