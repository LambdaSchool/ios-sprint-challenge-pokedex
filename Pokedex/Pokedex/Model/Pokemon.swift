//
//  Pokemon.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import Foundation


struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    let abilities: [PokemonAbilities] // main
    var types: [PokemonType] // main
    var sprites: Sprites // main
    
    
    
    
    
    struct PokemonAbilities: Codable, Equatable {
        var ability: Ability
    }
    struct Ability: Codable, Equatable {
        var name: String
    }
    
    
    struct PokemonType: Codable, Equatable {
        var type: Types
    }
    struct Types: Codable, Equatable {
        var name: String
    }
    
    
    struct Sprites: Codable, Equatable {
        var front_default: String
    }


    
}
