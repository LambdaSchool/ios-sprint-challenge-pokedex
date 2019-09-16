//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [TypeRoot]
    let abilities: [AbilityRoot]
    let sprites: Sprite
}

struct TypeRoot: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct AbilityRoot: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String
}
