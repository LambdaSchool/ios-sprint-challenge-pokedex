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
    let abilities: [AbilityParent]
    let sprites: Sprites
    let types: [TypeParent]
}

struct AbilityParent: Decodable {
    let ability: AbilityChild
}

struct AbilityChild: Decodable {
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

struct TypeParent: Decodable {
    let type: TypeChild
}

struct TypeChild: Decodable {
    let name: String
}
