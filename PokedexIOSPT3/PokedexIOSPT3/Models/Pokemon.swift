//
//  Pokemon.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let sprites: Sprites
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case sprites
    }
}

struct PokemonType: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//    }
}

struct PokemonAbility: Codable {
    let ability: Ability
//
//    private enum CodingKeys: String, CodingKey {
//        case ability
//    }
}

struct Ability: Codable {
    let name: String
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//    }
}

struct Sprites: Codable {
    let front_default: String
//
//    private enum CodingKeys: String, CodingKey {
//        case defaultImage = "front_default"
//    }
}

