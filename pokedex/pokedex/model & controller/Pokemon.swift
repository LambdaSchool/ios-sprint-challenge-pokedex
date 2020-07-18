//
//  Pokemon.swift
//  pokedex
//
//  Created by ronald huston jr on 5/28/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    let id: Int
    let name: String
    let abilities: [AbilityName]
    let types: [Types]
    let sprites: Picture
    
    
    struct Types: Codable, Equatable {
        let type: TypeInfo
        
        struct TypeInfo: Codable, Equatable {
            let name: String
        }
    }

    struct AbilityName: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }


    struct Picture: Codable, Equatable {
        let imageUrl: String
        let front: URL
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
            case front = "front_shiny"
        }
    }
}
