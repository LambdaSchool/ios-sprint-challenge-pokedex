//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    // Mark: - Properties

    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites
    
    // Mark: - Computed Properties

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

// Mark: - Ability Object Decoding Architecture

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

// Mark: - Type Object Decoding Architecture

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

// Mark: - Sprite Object Decoding Architecture

struct Sprites: Codable {
    let defaultSpriteUrl: String
    
    enum CodingKeys: String, CodingKey {
        case defaultSpriteUrl = "front_default"
    }
}

// Mark: - Equatable Extension

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
