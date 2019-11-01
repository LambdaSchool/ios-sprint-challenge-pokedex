//
//  Pokemon.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    var name: String
    var id: Int
    var abilities: [AbilityContainer]
    var types: [KindContainer]
    var sprites: SpriteContainer
    var image: Data?
}

struct AbilityContainer: Codable, Equatable {
    var ability: Ability
}

struct Ability: Codable, Equatable {
    var name: String
}

struct KindContainer: Codable, Equatable {
    var type: Kind
}

struct Kind: Codable, Equatable {
    var name: String
}

struct SpriteContainer: Codable, Equatable {
    var frontDefault: String
}
