//
//  Pokemon.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/24/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let abilities: [Ability]
    

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


struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
    
}
