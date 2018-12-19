//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

struct PokemonModel: Codable {
    let name: String
    let id: Int
    var abilities: [PokemonAbility]
    let types: [PokemonTypes]
    let sprites: PokemonSprite
    
    struct PokemonSprite: Codable {
        let frontDefault: String
    }
    
    struct PokemonAbility: Codable {
        let ability: PokemonAbilityName
        
        struct PokemonAbilityName: Codable {
            let name: String
        }
    }
    struct PokemonTypes: Codable {
        let type: PokemonTypeName
        
        struct PokemonTypeName: Codable {
            let name: String
        }
    }
    
    
}
