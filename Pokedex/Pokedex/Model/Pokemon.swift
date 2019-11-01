//
//  Pokemon.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    
    var name: String
    var id: Int
    
    
    let abilities: [PokemonAbilities] // main
        struct PokemonAbilities: Codable {
                var ability: Ability
            }
            struct Ability: Codable {
                    var name: String
                }
    
    
    var types: [PokemonType] // main
        struct PokemonType: Codable {
            var type: Types
        }
            struct Types: Codable {
                var name: String
            }

    
    var sprites: Sprites // main
        struct Sprites: Codable {
            var front_shiny: String
        }


    
}
