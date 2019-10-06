//
//  Model.swift
//  ios-Sprint-Challenge-Pokedex
//
//  Created by Jonalynn Masters on 10/5/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: SpriteFront
    
    struct AbilityInfo: Codable {
        let ability: Ability
        
        struct Ability: Codable {
            let name: String
        }
    }
    
    struct TypeInfo: Codable {
        let type: TypieType
        
        struct TypieType: Codable {
            let name: String
        }
    }
    
    struct SpriteFront: Codable {
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
        }
    }
}

