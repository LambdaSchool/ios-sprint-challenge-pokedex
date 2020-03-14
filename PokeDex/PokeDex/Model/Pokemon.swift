//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites
    
    struct Sprites: Codable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "front_default"
        }
    }
    
    struct Types: Codable {
        let slot: Int
        let type: Type
        
        struct `Type`: Codable {
            let name: String
            let url: String
        }
    }
    
    struct Abilities: Codable {
        let isHidden: Bool
        let slot: Int
        let ability: Ability
        
        enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case slot = "slot"
            case ability = "ability"
        }
        struct Ability: Codable {
            let name: String
            let url: String
        }
    }
}

struct PokemonSearchResults: Codable {
    let results: Pokemon
}

