//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nicolas Rios on 11/26/19.
//  Copyright © 2019 Nicolas Rios. All rights reserved.
//

import Foundation
import UIKit


struct Pokemon: Codable, Equatable {
    
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: SpriteFront
    
    
    struct AbilityInfo: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    
    struct TypeInfo: Codable, Equatable {
        let type:TypieType
        
        struct TypieType: Codable, Equatable {
            let name: String
        }
    }
    
    
    struct SpriteFront: Codable, Equatable {
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
        }
    }
}
