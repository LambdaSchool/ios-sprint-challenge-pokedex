//
//  Pokemon.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Type]
    let sprites: Sprites
}

struct Ability: Codable {
    let ability: String
}

struct Type: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_Default"
    }
}
