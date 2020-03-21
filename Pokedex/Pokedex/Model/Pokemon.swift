//
//  Pokemon.swift
//  Pokedex
//
//  Created by Claudia Contreras on 3/20/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: [Types]
    let abilities: [Abilities]
    let sprites: Image
    
    
    struct Types: Codable {
        let type: Types
        
        struct Types: Codable {
            let name: String
        }
    }
    
    
    struct Abilities: Codable {
        let ability: AbilityName
        
        struct AbilityName: Codable {
            let name: String
        }
    }
    
    struct Image: Codable {
        let defaultImageURL: URL
        
        enum CodingKeys: String, CodingKey {
            case defaultImageURL = "front_default"
        }
    }
    
}
