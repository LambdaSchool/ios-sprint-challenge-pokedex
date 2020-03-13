//
//  Pokemon.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [PokemonAbilityWrapper]
    let sprites: PokemonSprites
    let types: [PokemonTypeWrapper]
}

struct PokemonSprites: Codable {
    let frontDefault: String
    let frontShiny: String
    let frontFemale: String
    let frontShinyFemale: String
    let backDefault: String
    let backShiny: String
    let backFemale: String
    let backShinyFemale: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
    }
}

struct PokemonTypeWrapper: Codable {
    let type: PokemonType
}
struct PokemonType: Codable {
    let name: String
}

struct PokemonAbilityWrapper: Codable {
    let ability: PokemonAbility
}

struct PokemonAbility: Codable {
    let name: String
}
