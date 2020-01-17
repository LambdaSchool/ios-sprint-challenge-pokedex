//
//  Pokemon.swift
//  Pokedex
//
//  Created by Michael on 1/17/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.name == rhs.name && lhs.id == rhs.id
    }
    let id: Int
    let name: String
    let abilities: [Abilities]
    let sprites: Sprites
    let types: [TypeElement]
}

struct Abilities: Decodable {
    let ability: [Ability]
}

struct Ability: Decodable {
    let name: String
}

struct Sprites: Decodable {
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct TypeElement: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}
