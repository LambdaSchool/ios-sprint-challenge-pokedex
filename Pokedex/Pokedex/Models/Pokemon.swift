//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eoin Lavery on 20/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

struct AbilityJSONObject: Codable {
    let ability: AbilityRAWObject
}

struct AbilityRAWObject: Codable {
    let name: String
}

struct PokemonImage: Codable {
    let front_default: String
}

struct PokemonTypeJSONObject: Codable {
    let type: PokemonTypeRAWObject
}

struct PokemonTypeRAWObject: Codable {
    let name: String
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [AbilityJSONObject]
    let sprites: PokemonImage
    let types: [PokemonTypeJSONObject]
}
