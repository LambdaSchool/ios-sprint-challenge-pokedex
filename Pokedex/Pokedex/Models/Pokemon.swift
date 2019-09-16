//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [Types]
    let abilities: [Abilities]
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case types
        case abilities
        case sprites
    }
    
}

struct Types: Codable {
    let type: Type
}

struct Abilities: Codable {
    let ability: Ability
}

struct Type: Codable {
    let name: String
}

struct Ability: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String
}
