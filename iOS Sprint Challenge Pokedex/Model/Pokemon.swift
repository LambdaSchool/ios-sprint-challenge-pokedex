//
//  Pokemon.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    enum PokemonCodingKeys: String, CodingKey {
        case id = "order"
    }
    
    var name: String
    var id: String
    var abilities: [Abilities]
    var types: [Types]

}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
