//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let abilities: [AbilityObject]
    let types: [TypeObject]
    let sprites: Sprites
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case sprites
    }
}

struct TypeObject: Decodable {
//    let slot: Int
    let type: Type
    
//    private enum CodingKeys: String, CodingKey {
//        case type
//        case slot
//    }
}

struct Type: Decodable {
    let name: String
//    let url: String
    private enum CodingKeys: String, CodingKey {
        case name
    }
}

struct AbilityObject: Decodable {
    let ability: Ability
//    let is_hidden: Bool
    private enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct Ability: Decodable {
    let name: String
//    let url: String
    private enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Sprites: Decodable {
    let front_default: String
    
//    private enum CodingKeys: String, CodingKey {
//        case defaultImage = "front_default"
//    }
}
