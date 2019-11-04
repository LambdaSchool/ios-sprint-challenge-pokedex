//
//  Pokemon.swift
//  Pokedex
//
//  Created by Rick Wolter on 11/3/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation

// Establish a Pokemon record with properties for the Pokemon's name, ID, ability, and types.
struct Pokemon: Codable, Equatable {
    
    var name: String
       var id: Int
       let abilities: [PokemonAbility]
       var types: [PokemonType]
       var sprites: Sprites
  
    
}

struct PokemonType: Equatable, Codable {
       let type: Type
   }
struct Type: Equatable, Codable {
    let name: String
}

struct PokemonAbility: Equatable, Codable {
    let ability: Ability
        
}
struct Ability: Equatable, Codable {
        let name: String
    }

 struct Sprites: Codable, Equatable {
     var front_default: String
 }

