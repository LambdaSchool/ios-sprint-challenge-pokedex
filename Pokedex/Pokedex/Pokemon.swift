//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
         lhs.name == rhs.name
    }
    
    let id: Int
    let name: String
    let ability: Abilities
    let types: Types
    let sprites: Sprites
    
   
}

struct Abilities: Codable, Equatable {
    let is_hidden: Bool
    let slot: Int
    let name: String
    
}

struct Sprites: Codable, Equatable {
    let defaultSpriteUrl: String
    enum CodingKeys: String, CodingKey {
        case defaultSpriteUrl = "front_default"
    }
}

struct Types: Codable, Equatable {
    let name: String
}

struct SearchResults: Codable, Equatable {
    let results: [Pokemon]
}
