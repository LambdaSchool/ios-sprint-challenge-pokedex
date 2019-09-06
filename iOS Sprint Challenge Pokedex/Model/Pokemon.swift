//
//  Pokemon.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation


struct PokemonResult: Codable {
    let abilities : [Pokemon]
    let types: [Pokemon]
}

struct Pokemon: Codable {
    
    enum PokemonCodingKeys: String, CodingKey {
        case id = "order"
    }
    
    var name: String
    var id: String
    var types: Type
    var ability: Ability
}

struct Ability: Codable {
    var name: String
}

struct Type: Codable {
    var name: String
}
