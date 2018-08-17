//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokemonType]
    
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
