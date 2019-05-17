//
//  Pokemon.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let types: [TypeElement]
    let abilities: [Ability]
    let sprites: Sprites
    
}

struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
struct Species: Codable {
    let name: String
}
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
