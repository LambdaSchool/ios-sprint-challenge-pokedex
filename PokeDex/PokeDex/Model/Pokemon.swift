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
struct Pokemon: Decodable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Type]
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
struct Ability: Decodable {
    let name: String
}

//MARK: Pokemon Types
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
