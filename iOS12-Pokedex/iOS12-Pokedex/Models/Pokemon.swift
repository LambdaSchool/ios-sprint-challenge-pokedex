//
//  Pokemon.swift
//  iOS12-Pokedex
//
//  Created by Patrick Millet on 12/6/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable, Hashable {
    var name: String
    var id: Int
    var abilities: [AbilityContainer]
    var types: [KindContainer]
    var sprites: SpriteContainer
    var image: Data?

    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
}

// MARK: - Internal Types
struct AbilityContainer: Codable, Equatable, Hashable {
    var ability: Ability
}

struct Ability: Codable, Equatable, Hashable {
    var name: String
}

struct KindContainer: Codable, Equatable, Hashable {
    var type: Kind
}

struct Kind: Codable, Equatable, Hashable {
    var name: String
}

struct SpriteContainer: Codable, Equatable, Hashable {
    var frontDefault: String
}
