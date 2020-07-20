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
    let abilityName: String
}

struct PokemonImage: Codable {
    let frontDefault: String
}

struct PokemonTypeJSONObject: Codable {
    let name: String
}

struct PokemonTypeRAWObject: Codable {
    let type: PokemonTypeJSONObject
}

struct Pokemon: Codable {
    let pokemonName: String
    let pokemonID: Int
    let abilities: [AbilityRAWObject]
    let image: PokemonImage
    let types: [PokemonTypeRAWObject]
}
