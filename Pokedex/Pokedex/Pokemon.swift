//
//  Pokemon.swift
//  Pokedex
//
//  Created by Morgan Smith on 1/27/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [AbilityElement]
    let name: String
    let id: String
    let types: [TypeElement]

    struct AbilityElement: Codable {
        let ability: Ability
      
        struct Ability: Codable {
            let name: String
        }
    }
    
    struct TypeElement: Codable {
        let type: TypeName
        
        struct TypeName: Codable {
            let name: String
        }
    }
}
