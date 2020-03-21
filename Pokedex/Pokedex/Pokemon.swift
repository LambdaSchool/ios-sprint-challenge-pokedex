//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 3/20/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let type: [String]
    let abilities: [String]
}


struct PokemonSearch: Decodable {
    let results: [Pokemon]
}
