//
//  Pokemon.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

struct Pokemon {
    let name: String
    let id: Int
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    
}

struct PokemonAbility {
    let is_hidden: Bool
    let slot: Int
    let ability: Ability
}

struct Ability {
    let name: String
    let url: String
}

struct PokemonType {
    let slot: Int
    let type: Type
}

struct Type {
    let id: Int
    let name: String
}
