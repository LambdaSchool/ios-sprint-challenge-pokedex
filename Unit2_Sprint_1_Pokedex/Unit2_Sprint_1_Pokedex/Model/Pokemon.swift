//
//  Pokemon.swift
//  Unit2_Sprint_1_Pokedex
//
//  Created by Brian Rouse on 5/8/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let sprites: Sprites
    let types: [Type]
}

struct Ability: Codable {
    let ability: Name
}

struct Type: Codable {
    let type: Name
}

struct Name: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

