//
//  AllPokemon.swift
//  Pokedex
//
//  Created by alfredo on 1/25/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

struct APIPokedexRequestContainer: Codable{
    let count: Int
    let results: [PokemonNameAndURL]
}
