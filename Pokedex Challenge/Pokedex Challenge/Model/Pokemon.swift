//
//  Pokemon.swift
//  Pokedex Challenge
//
//  Created by Michael Flowers on 1/25/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
   
    //REMEMBER EVERY OPEN BRACKET ON THE JSON means that we have to create a new struct.
    var name: String
    let id: Int
    let abilities: [AbilityArray]
    let types: [TypeArray]
    let sprites: SpriteDictionary
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.abilities == rhs.abilities && lhs.sprites == rhs.sprites && lhs.types == rhs.types
    }
    
}

struct AbilityArray: Codable, Equatable {
    let ability: [AbilityDictionary]
    
    static func == (lhs: AbilityArray, rhs: AbilityArray) -> Bool {
        return lhs.ability == rhs.ability
    }
}

struct AbilityDictionary: Codable, Equatable {
    let name: String
    
}

struct TypeArray: Codable, Equatable {
    let type:TypeDictionary
}

struct TypeDictionary: Codable, Equatable {
    let name: String
}

struct SpriteDictionary: Codable, Equatable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
