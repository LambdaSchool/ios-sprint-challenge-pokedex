//
//  Pokemon.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Types]
    let sprites: [Sprites]
    
    struct Ability: Equatable, Codable {
        let ability: [SubAbility]
        
        struct SubAbility: Equatable, Codable {
            let name: String
        }
    }
    
    struct Types: Equatable, Codable {
        let type: [type]
        
        struct type: Equatable, Codable {
            let name: String
        }
        
    }
    
    struct Sprites: Equatable, Codable {
        let spriteName: String
        
        enum CodingKeys: String, CodingKey {
            case spriteName = "front_default"
        }
    }
    
}




