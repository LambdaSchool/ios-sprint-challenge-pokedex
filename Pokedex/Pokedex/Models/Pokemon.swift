//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    let name: String
    let id: Int
    let types: [String]
    let abilities: [String]
    
    init(name: String, id: Int, types: [String], abilities: [String]) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
    }
}

struct APIAbility: Codable {
    let name: String
}

struct APIPokemonType: Codable {
    let type: [String: String]
}

struct APIPokemon: Codable {
    let name: String
    let id: Int
    let types: [APIPokemonType]
    let abilities: [APIAbility]
}
