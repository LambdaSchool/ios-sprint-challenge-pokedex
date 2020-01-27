//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

struct PokemonType: Codable {
    var name: String
}

struct PokemonAbility: Codable {
    var name: String
}

struct PokemonAbilityAPIObject: Codable {
    var ability: PokemonType
}

struct PokemonTypeAPIObject: Codable {
    var type: PokemonType
}

struct PokemonSprites: Codable {
    let front_default: String
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: [PokemonTypeAPIObject]
    let abilities: [PokemonAbilityAPIObject]
    let sprites: PokemonSprites
}
