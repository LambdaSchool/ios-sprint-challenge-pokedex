//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gerardo Hernandez on 1/27/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
 
struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprite
    
}


struct Abilities: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct Types: Codable, Equatable {
    let type: TypeName
}


struct TypeName: Codable, Equatable {
    let name: String
}

struct Sprite: Codable, Equatable {
    let front_shiny: String
}

struct PokemonArray: Codable, Equatable {
    let pokemons: [Pokemon]
}
