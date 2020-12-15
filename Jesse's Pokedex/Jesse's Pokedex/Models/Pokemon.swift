//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokemonType]
    let sprites: Sprite
    
    struct Ability: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    
    struct PokemonType: Codable, Equatable {
        let type: Types
        
        struct Types: Codable, Equatable {
            let name: String
        }
    }
    
    struct Sprite: Codable, Equatable {
        let front_default: String
    }
}
