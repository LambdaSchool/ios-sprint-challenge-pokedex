//
//  Pokemon.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let sprites: Image
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    
    struct AbilityInfo: Codable, Equatable {
        let ability: AbilityName
        
        struct AbilityName: Codable, Equatable {
            let name: String
        }
    }
    
    struct TypeInfo: Codable, Equatable {
        let type:Types
        
        struct Types: Codable, Equatable {
            let name: String
        }
    }
    
    struct Image: Codable, Equatable {
        let defaultImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case defaultImageURL = "front_default"
        }
    }
}
