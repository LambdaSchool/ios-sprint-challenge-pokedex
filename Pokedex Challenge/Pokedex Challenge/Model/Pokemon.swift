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
    let abilities: [AbilitDictionary] //need the [] because it tells the compiler that it's layred
    let types: [TypeArray] //need the [] because it tells the compiler that it is layred
    let sprites: SpriteDictionary
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.sprites == rhs.sprites && lhs.abilities == rhs.abilities  && lhs.types == rhs.types
    }
    
}

struct AbilitDictionary: Codable, Equatable {
    let ability: Ability

    static func == (lhs: AbilitDictionary, rhs: AbilitDictionary) -> Bool {
        return lhs.ability == rhs.ability
    }
}

struct Ability: Codable, Equatable {
    let name: String
}

struct TypeArray: Codable, Equatable {
    let type: Type
}

struct Type: Codable, Equatable {
    let name: String
}

struct SpriteDictionary: Codable, Equatable {
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
