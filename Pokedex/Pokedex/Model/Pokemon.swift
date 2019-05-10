//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokemonType]
    let sprites: [SpriteStruct]
    
    struct SpriteStruct: Equatable, Codable {
        let frontDefault: String
    }
    
    struct Ability: Equatable, Codable {
        let ability: SubAbility
        
        struct SubAbility: Equatable, Codable {
            let name: String
        }
    }
    
    struct PokemonType: Equatable, Codable {
        let type: SubPokemonType
        
        struct SubPokemonType: Equatable, Codable {
            let name: String
        }
    }
}
