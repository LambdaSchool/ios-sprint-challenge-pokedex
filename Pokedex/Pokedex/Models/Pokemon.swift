//
//  Pokemon.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let abilities: [String]
    let types: [PokemonType]
}

struct PokemonType: Decodable {
    let name: String
    let url: String
}
