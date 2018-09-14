//
//  Pokémon.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

struct Pokémon: Codable, Equatable {
    
    let id: Int
    let name: String
    let abilities: [PokémonAbility]
    let types: [PokémonType]
    let sprites: [String: String]
    
    struct PokémonAbility: Codable, Equatable {
        let ability: PokémonResource
    }
    
    struct PokémonType: Codable, Equatable {
        let type: PokémonResource
    }
    
}

struct PokémonResource: Codable, Equatable {
    let name: String
}
