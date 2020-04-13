//
//  Pokemon.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [TypeRoot]
    let abilities: [AbilitiesRoot]
    let sprites: Sprite
}

struct TypeRoot: Codable {
    var type: Types
}

struct Types: Codable {
    var name: String
}

struct AbilitiesRoot: Codable {
    var ability: Ability
}

struct Ability: Codable {
    var name: String
}

struct Sprite: Codable {
    var front_default: String
}
