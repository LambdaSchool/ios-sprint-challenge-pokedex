//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
 
struct Pokemon: Codable {
    let name: String
    let id: Int
    let ability: String
    let types: String
}


struct PokemonSearchResults: Codable {
    let pokemonSearchResults: [Pokemon]
}
