//
//  Model.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 1/25/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let sprites: Sprites
    let types: [Types]
}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Types: Codable {
    let type: SubType
}

struct SubType: Codable {
    let name: String
}
