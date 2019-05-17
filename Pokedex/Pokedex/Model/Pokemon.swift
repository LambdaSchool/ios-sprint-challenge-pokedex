//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Type]
    let sprites: Sprite
}

struct Ability: Codable {
    let ability: Species
}

struct Type: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
}

struct Sprite: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
