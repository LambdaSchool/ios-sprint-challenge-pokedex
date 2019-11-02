//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let imageURL: String
}

struct Abilities: Codable {
    let ability: String
}

struct PokemonSearch: Codable {
    let results: Pokemon
}
