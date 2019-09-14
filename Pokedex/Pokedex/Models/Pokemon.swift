//
//  Pokemon.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let sprites: Sprite
}

struct PokemonAbility: Decodable {
    let ability: Species
}

struct PokemonType: Decodable {
    let type: Species
}

struct Species: Decodable {
    let name: String
}

struct Sprite: Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


