//
//  Pokemon.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let sprites: Sprites
    let id: Int
    let types: [Types]
    let abilities: [Abilities]
}

struct Sprites: Codable, Equatable {
    let frontDefault: String
}

struct Abilities: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct Types: Codable, Equatable {
    let type: Type
}

struct Type: Codable, Equatable {
    let name: String
}
