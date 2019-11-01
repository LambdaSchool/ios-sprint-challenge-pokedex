//
//  PokemonResult.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_204 on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct PokemonResult: Equatable, Codable {
    let name: String
    let id: Int
    
    let types: [PokemonType]
    struct PokemonType: Equatable, Codable {
        let type: Type
        struct `Type`: Equatable, Codable {
            let name: String
        }
    }


    let abilities: [PokemonAbility]
    struct PokemonAbility: Equatable, Codable {
        let ability: Ability
        struct Ability: Equatable, Codable {
            let name: String
        }
    }
    
    let sprites: PokemonSprites
    struct PokemonSprites: Equatable, Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

