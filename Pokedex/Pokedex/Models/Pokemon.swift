//
//  Pokemon.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
  
    let id: Int
    let name: String
    let sprites: Sprite
    let abilities: [Ability]
    let types: [PokeType]
    
    struct Ability: Codable {
        let ability: Ability
        
        struct Ability: Codable {
            let name: String
        }
    }
    
    struct PokeType: Codable {
        let type: PokeType
        
        struct PokeType: Codable {
            let name: String
        }
    }
    
    struct Sprite: Codable {
        let front_default: String
    }
}
