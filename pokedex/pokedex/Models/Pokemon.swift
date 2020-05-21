//
//  Pokemon.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Equatable {
    
    let abilities: [Ability]
    
    struct Ability: Decodable, Equatable {
        
        let ability: SubAbility
        
        struct SubAbility: Decodable, Equatable {
            
            let name: String
        }
    }
    let id: Int
    let name: String
    let sprites: Sprites
    struct Sprites: Decodable, Equatable {
        
        let frontDefault: String
    }
    
    let types: [TypeElement]
    
    
    struct TypeElement: Decodable, Equatable {
        let type: SubType
        
        struct SubType: Decodable, Equatable {
            let name: String
        }
    }
}


