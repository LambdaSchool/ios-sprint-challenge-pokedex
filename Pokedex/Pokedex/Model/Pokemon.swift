//
//  Pokemon.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable
{
    let name: String
    let id: Int
    let abilities: String
    let types: String
    
}

struct PokemonSearchResult: Codable
{
    var results: [Pokemon]
}
