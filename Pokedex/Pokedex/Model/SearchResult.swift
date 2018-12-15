//
//  SearchResult.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
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

////Get the Pokemon sprite
//struct Sprite: Codable {
//    let front_default: String
//}
