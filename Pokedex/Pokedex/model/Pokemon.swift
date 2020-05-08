//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vincent Hoang on 5/8/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
    let abilities: [PokemonAbility]
}

struct PokemonType: Codable {
    let type: TypeResource
}

struct PokemonAbility: Codable {
    let ability: AbilityResource
}

struct TypeResource: Codable {
    let name: String
}

struct AbilityResource: Codable {
    let name: String
}

struct NamedAPIResource: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    let front_default: String
}
