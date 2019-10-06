//
//  Pokemon.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct PokemonSearch: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let ability: String
    let types: String
    let imageURL: String  // TODO: might have to set this with a didSet so it takes in a number inside the string to determine wich picture of this pokemon
    
    
    enum CodingKeys: String, CodingKey {

        case name = "name"
        case id = "id"
        case ability = "abilities"
        case types = "types"
        case imageURL = "sprite"
    }
}

struct Abilities: Codable {
    let abilitiesArray: [Ability]

    struct Ability: Codable {
        let abilities: String
    }
}
