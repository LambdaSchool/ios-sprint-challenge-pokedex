//
//  PokemonAPIData.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 5/17/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

struct PokemonAPIData: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [PokemonTypes]
    let sprites: Sprites
}

struct Abilities: Codable {
    let ability: Ability
    
}

struct Ability: Codable {
    let name: String
}

struct PokemonTypes: Codable {
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String
}

