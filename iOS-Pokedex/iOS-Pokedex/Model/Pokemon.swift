//
//  Pokemon.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import Foundation

//Testing
struct PokemonTesting: Codable {
    let abilities: [Ability]
    let forms: [Species]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    let frontDefault: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

