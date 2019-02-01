//
//  Pokemon.swift
//  w3r Pokedex Challenge
//
//  Created by Michael Flowers on 2/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [AbilityArray]
    let sprites: SpriteDictionary
    let types: [TypeArray]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.sprites == rhs.sprites && lhs.abilities == rhs.abilities  && lhs.types == rhs.types
    }
}

struct AbilityArray: Codable, Equatable {
    let ability: Ability
    
    static func == (lhs: AbilityArray, rhs: AbilityArray) -> Bool {
        return lhs.ability == rhs.ability
    }
}

struct Ability: Codable, Equatable {
    let name: String
}

struct SpriteDictionary: Codable, Equatable {
    let urlImage: URL
    
    enum CodingKeys: String, CodingKey {
        case urlImage = "front_default"
    }
}

struct TypeArray: Codable, Equatable{
    let type: Type
}

struct Type: Codable, Equatable {
    let name: String
}
