//
//  Pokemon.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation
import UIKit

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
