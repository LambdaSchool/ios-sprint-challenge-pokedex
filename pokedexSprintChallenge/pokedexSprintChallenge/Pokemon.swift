//
//  Pokemon.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    let name: String
    var image: Image
    var id: Int
    var types: [Types]
    var abilities: [Abilities]
}

struct Image: Codable {
    
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonSearch: Codable {
    let results: [Pokemon]
}

struct Types: Codable {
    let type: Species
}

struct Abilities: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
}



