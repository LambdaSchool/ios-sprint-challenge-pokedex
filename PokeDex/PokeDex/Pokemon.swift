//
//  Pokemon.swift
//  PokeDex
//
//  Created by Dojo on 7/19/20.
//  Copyright © 2020 Dojo. All rights reserved.
//

import UIKit

struct Pokemon: Codable {

    
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites

    
    var abilityNames: [String] {
        return abilities.map { $0.ability.name }
    }

    var typeNames: [String] {
        return types.map { $0.type.name }
    }

    var spriteURL: String {
        return sprites.defaultSpriteUrl
    }
}


struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}


struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct Sprites: Codable {
    let defaultSpriteUrl: String

    enum CodingKeys: String, CodingKey {
        case defaultSpriteUrl = "front_default"
    }
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
