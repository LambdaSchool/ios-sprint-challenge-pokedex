//
//  Pokemon.swift
//  Pokedex
//
//  Created by Madison Waters on 9/21/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    var name: String
    var id: String
    var abilities: String
    var types: String
    
}

struct PokemonSearchResults: Codable {
    var pokemonResults: Pokemon
}
