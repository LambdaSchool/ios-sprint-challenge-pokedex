//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    let name: String?
    let id: Int?
    let types: [String]?
    let abilities: [String]?
}

class APIAbility: Codable {
    let name: String?
}

class APIPokemonType: Codable {
    let type: [String: String]
}

struct APIPokemon {
    let name: String
    let id: Int
    let types: [APIPokemonType]
    let abilities: [APIAbility]
}
