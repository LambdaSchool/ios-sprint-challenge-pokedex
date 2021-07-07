//
//  Pokemon.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/13/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation
import UIKit


struct Pokemon: Codable, Equatable {
    
    let name: String
    let types: [TypeArray]
    let abilities: [AbilityArray]
    let id: Int
    let sprites: SpriteFront
    
    
    struct AbilityArray: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    
    struct TypeArray: Codable, Equatable {
        let type: Types
        
        struct Types: Codable, Equatable {
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


