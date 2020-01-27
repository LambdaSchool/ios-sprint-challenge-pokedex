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
    var abilities: [PokemonAbility]
}

struct PokemonTypeAPIObject: Codable {
    var types: [PokemonType]
}


struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: PokemonTypeAPIObject
    let abilities: PokemonAbilityAPIObject
}
