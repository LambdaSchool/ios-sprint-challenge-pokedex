//
//  other.swift
//  Pokedex
//
//  Created by alfredo on 1/25/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation



struct Types: Codable{
    let slot: Int
    let type: [PokemonNameAndURL]
}
struct Type: Codable{
    let slot: Int
    let type: PokemonNameAndURL
}
struct PokemonInformation: Codable{
    var abilities: [Ability]
    var height: Int
    var id: Int
    var species: PokemonNameAndURL
    let sprites: Sprites
    let weight: Int
    let types: [Type]
}
