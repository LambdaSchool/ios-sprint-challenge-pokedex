//
//  Pokemon.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites?
    
    struct Types: Codable {
        let type: Name
    }
    
    struct Abilities: Codable {
        let ability: Name
    }
    
    struct Name: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
