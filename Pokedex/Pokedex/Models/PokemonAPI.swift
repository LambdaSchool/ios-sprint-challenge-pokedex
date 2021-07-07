//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Sameera Roussi on 5/10/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import Foundation

import Foundation

struct PokemonAPI: Codable {
    let name: String?
    let id: Int
    let abilities: [Abilities]
    let types: [Type]
    let sprites: Sprite
}

// GET the Pokemon abilities
struct Ability: Codable {
    let name: String
}
struct Abilities: Codable {
    let ability: Ability
}

// GET the Pokemon types
struct Types: Codable {
    let name: String
}
struct Type: Codable {
    let type: Types
}

//Get the Pokemon sprite
struct Sprite: Codable {
    let frontDefault: String
    
}
