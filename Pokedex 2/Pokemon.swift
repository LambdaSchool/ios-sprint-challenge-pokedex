//
//  Pokemon.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites
    
    var abilitiesName: [String] {
        return abilities.map { $0.ability.name}
    }
    var typesName: [String] {
        return types.map {$0.type.name}
    }
    var spritesName: String {
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

struct Sprites: Codable  {
    let defaultSpriteUrl: String
    
    enum CodingKeys: String, CodingKey {
    case defaultSpriteUrl = "front_default"
    }
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
}
