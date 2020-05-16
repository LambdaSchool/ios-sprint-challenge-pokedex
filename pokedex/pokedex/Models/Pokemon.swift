//
//  Pokemon.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
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
}

struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: Species
}
