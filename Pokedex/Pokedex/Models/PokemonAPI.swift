//
//  SearchResult.swift
//  Sprint 3: Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

struct PokemonAPI: Codable {
    let name: String?
    let id: Int
    let abilities: [Abilities]
    let types: [Type]
//    let sprites: Sprite
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
//struct Sprite: Codable {
//    let sprite: String
//    struct ImageURLs: Codable {
//        let frontDefault: String
//    }
//}
