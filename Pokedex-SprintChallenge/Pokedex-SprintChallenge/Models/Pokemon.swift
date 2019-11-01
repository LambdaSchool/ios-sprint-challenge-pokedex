//
//  Pokemon.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [AbilityContainer]
    let types: [KindContainer]
    let sprites: SpriteContainer
}

struct AbilityContainer: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct KindContainer: Codable, Equatable {
    let type: Kind
}

struct Kind: Codable, Equatable {
    let name: String
}

struct SpriteContainer: Codable, Equatable {
    let frontDefault: String
}
