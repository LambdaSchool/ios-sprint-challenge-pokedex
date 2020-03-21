//
//  Pokemon.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: String
    let abilities: String
    let types: String
    let sprites: String
}

struct PokemonSearch: Decodable {
    let results: [Pokemon]
}
