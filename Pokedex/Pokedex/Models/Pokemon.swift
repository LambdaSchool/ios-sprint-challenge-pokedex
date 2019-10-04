//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gi Pyo Kim on 10/4/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
    let id: Int
    let name: String
    let sprites: PokemonImage
    let types: [Type]
}

struct Ability: Codable {
    let ability: PokeAbility
}

struct PokeAbility: Codable {
    let name: String
}

struct PokemonImage: Codable {
    let front_default: String
}

struct Type: Codable {
    let type: PokeType
}

struct PokeType: Codable {
    let name: String
}
