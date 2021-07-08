//
//  PokemonSearchResults.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

// individual entry
struct PokemonSearchResults: Codable{
    let id: Int
    let name: String
    let types: [Pokemon.TypeElement]
    let abilities: [Pokemon.AbilityElement]
    let sprites: Pokemon.Sprites
  
}
