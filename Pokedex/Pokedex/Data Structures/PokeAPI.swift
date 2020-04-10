//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Shawn James on 4/10/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
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
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
