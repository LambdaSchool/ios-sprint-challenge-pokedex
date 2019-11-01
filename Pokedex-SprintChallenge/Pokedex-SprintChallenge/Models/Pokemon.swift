//
//  Pokemon.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    let name: String
    let id: Int
    let abilities: [AbilityContainer]
    let types: [KindContainer]
    let sprites: SpriteContainer
}

struct AbilityContainer: Decodable, Equatable {
    let ability: Ability
}

struct Ability: Decodable, Equatable {
    let name: String
}

struct KindContainer: Decodable, Equatable {
    let type: Kind
}

struct Kind: Decodable, Equatable {
    let name: String
}

struct SpriteContainer: Decodable, Equatable {
    let frontDefault: String
}
