//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct PokemonSearch: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let image: String
    let id: Int
    let type: String
    let ability: String
}
