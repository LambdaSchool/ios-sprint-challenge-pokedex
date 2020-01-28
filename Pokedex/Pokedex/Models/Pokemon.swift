//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

//Establish a Pokemon record with properties for the Pokemon's name, ID, ability, and types.
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
        let type: PokeType
        
        struct PokeType: Codable, Equatable {
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

 
