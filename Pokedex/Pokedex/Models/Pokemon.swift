//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jonathan T. Miles on 8/10/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: Int
    let abilities: [Pokemon.Ability]
    let types: [Pokemon.PokemonType]
    
    struct Ability: Equatable, Codable {
        let name: String
    }
    
    struct PokemonType: Equatable, Codable {
        let name: String
    }
}

struct PokemonSearchResults: Codable {
    var results: [Pokemon]
}
