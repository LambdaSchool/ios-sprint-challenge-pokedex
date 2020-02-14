//
//  Pokemon.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit


struct Pokemon: Codable, Equatable {
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: Image
    
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
    
    struct Image: Codable, Equatable {
        let imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case imageURL = "front_default"
        }
    }
}
