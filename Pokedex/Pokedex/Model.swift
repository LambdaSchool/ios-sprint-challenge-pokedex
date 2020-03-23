//
//  Model.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_201 on 11/9/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
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
