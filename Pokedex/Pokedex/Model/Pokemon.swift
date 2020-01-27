//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

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
        return abilities.map { $0.ability.name }
    }
    
    var spriteURLString: String {
        return sprites.defaultSpriteUrlString
    }
}

// Mark: - Ability Objects

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

// Mark: - Type Objects

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

// Mark: - Sprite Objects

struct Sprites: Codable {
    let defaultSpriteUrlString: String
    
    enum CodingKeys: String, CodingKey {
        case defaultSpriteUrlString = "front_default"
    }
}
