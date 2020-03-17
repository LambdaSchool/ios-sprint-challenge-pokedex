//
//  Pokemon.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let abilities: [Ability]
    let id: Int
    
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

struct Species: Codable {
    let name: String
}

struct Ability: Codable {
    let ability: Species
}

