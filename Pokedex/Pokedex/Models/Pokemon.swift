//
//  Pokemon.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    // I care about abilities/ability/name
    let abilities: [Abilities]
    // I care about types/type/name
    let types: [Types]
    let sprites: Sprite

    struct Abilities: Codable {
        let ability: Ability
    }
        struct Ability: Codable {
            let name: String
        }
    
    struct Types: Codable {
        let type: PokeType
    }
        struct PokeType: Codable {
            let name: String
        }
    
    struct Sprite: Codable {
        var front_default: String
    }
}

