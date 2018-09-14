//
//  Pokemon.swift
//  Pokedex
//
//  Created by Moin Uddin on 9/14/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


struct Pokemon: Equatable, Codable {
    var name: String
    var id: Int
    var abilities: [PokemonAbility]
    var types: [PokemonType]
    
    struct PokemonType: Codable, Equatable {
        var type: NestedPokemonType
        struct NestedPokemonType: Codable, Equatable {
            var name: String
        }
    }
    
    struct PokemonAbility: Codable, Equatable {
        var ability: NestedPokemonAbility
        struct NestedPokemonAbility: Codable, Equatable {
            var name: String
        }
    }
}
