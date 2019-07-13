//
//  Pokemon.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [AbilityDictionary]
    let types: [TypeDictionary]
    let sprites: Sprites
    
    
    struct AbilityDictionary: Codable {
        let ability: AbilitySubDictionary
        
    }
    
    struct AbilitySubDictionary: Codable {
        let name: String
    }
    
    struct TypeDictionary: Codable {
        let type: TypeSubDictionary
    }
    
    struct TypeSubDictionary: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
