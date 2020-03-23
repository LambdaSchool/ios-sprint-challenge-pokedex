//
//  Model.swift
//  Pokedex
//
//  Created by Lambda_School_loaner_226 on 3/23/20.
//  Copyright © 2020 Lambda. All rights reserved.
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
