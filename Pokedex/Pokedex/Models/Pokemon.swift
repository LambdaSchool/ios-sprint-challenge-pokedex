//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

// Pokemon
struct Pokemon: Decodable, Equatable {
    
    var id: Int
    var name: String
    var sprites: PokemonSprites
    var abilities: [PokemonAbility]
    var types: [PokemonType]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
}

// Sprite Unwrap
struct PokemonSprites: Decodable {
    var front_default: String
}

// Ability Unwrap
struct PokemonAbility : Decodable {
    var ability: NamedAPIResource
}

// Types Unwrap
struct PokemonType: Decodable {
    var type: NamedAPIResource
}

// NamedAPIResource (Ability, Type)
struct NamedAPIResource: Decodable {
    var name: String
}
