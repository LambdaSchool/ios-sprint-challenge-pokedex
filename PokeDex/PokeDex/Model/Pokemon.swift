//
//  Pokemon.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    
    struct Ability: Decodable, Equatable {
        let ability: subAbility
        
        struct subAbility: Decodable, Equatable {
            let name: String
        }
    }
    
    let sprite: Sprite
    
    struct Sprite: Decodable, Equatable {
        let frontDefault: String
    }
    
    struct Types: Decodable, Equatable {
        let type: subType
        
        struct subType: Decodable, Equatable {
            let name: String
        }
    }
}

//struct PokemonSearch: Decodable {
//    let results: [Pokemon]
//}
