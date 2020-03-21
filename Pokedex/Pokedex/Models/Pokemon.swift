//
//  Pokemon.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let sprite: Image
    let abilities: [Ability]
    let type: [PokemonType]
    
    struct Ability: Codable, Equatable {
        let abilityName: AbilityName
        
        struct AbilityName: Codable, Equatable {
            let name: String
        }
    }
    
    struct PokemonType: Codable, Equatable {
        let typeName: TypeName
        
        struct TypeName: Codable, Equatable {
            let name: String
        }
    }
    
    struct Image: Codable, Equatable {
        let imageDefaultUrl = "front_default"
    }
    
}
