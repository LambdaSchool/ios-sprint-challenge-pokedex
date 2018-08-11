//
//  Pokemon.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable
{
    let name: String
    let id: Int

    
    let abilities: [Ability]
    
    struct Ability: Codable, Equatable
    {
        let ability: SubAbility
        
        struct SubAbility: Codable, Equatable
        {
            let name: String
        }
    }
    
    
    let types: [PokemonType]
    
    struct PokemonType: Codable, Equatable
    {
        let type: SubType
        
        struct SubType: Codable, Equatable
        {
            let name: String
        }
    }
}



