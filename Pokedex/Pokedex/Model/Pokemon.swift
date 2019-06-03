//
//  Pokemon.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

//enum CodingKeys: String, Codable {
//    case frontDefault = "front_default"
//}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    let sprites: Sprites
    
    struct Ability: Codable {
        let ability: AbilityDetail
    }
    
    struct AbilityDetail: Codable {
        let name: String
    }
    
    struct Types: Codable {
        let type: TypeDetail
    }
    
    struct TypeDetail: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let front_default: String
        
      
    }
}
