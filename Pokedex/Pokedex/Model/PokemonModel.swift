//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: SpriteFront
    
    
    
    
    struct TypeInfo: Codable, Equatable {
        let type: TypieType
        
        struct TypieType: Codable, Equatable {
            let name: String
        }
    }
    
    
    struct AbilityInfo: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
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
