//
//  Pokemon.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

//MARK: Pokemon names and url values
struct PokemonDataResults: Decodable {
    let results: [PokemonData]
}

struct PokemonData: Decodable {
    let name: String
    let url: String
}

//MARK: Pokemon Model
struct Pokemon: Decodable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    let picture: Picture
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case picture = "sprites"
    }
}


//MARK: Pokemon Abilities
struct Abilities: Decodable {
    let ability: Ability
}
struct Ability: Decodable {
    let name: String
}

//MARK: Pokemon Types
struct Types: Decodable {
    let type: Type
}
struct Type: Decodable {
    let name: String
}

//MARK: Pokemon Sprite
struct Picture: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}
