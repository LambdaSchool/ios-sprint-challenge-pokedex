//
//  Pokemon.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
   // var sprites:
    var abilities: [Pokemon.AbilityHelp]
    var types: [Pokemon.TypeHelp]
    
   /* init(name: String, id: Int, abilities: [Pokemon.AbilityHelp] = [], types: [Pokemon.TypeHelp] = []) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }*/
    
    struct AbilityHelp: Codable, Equatable {
        var ability: Ability
        
        struct Ability: Codable, Equatable {
            var name: String
        }
        
    }
    
    struct TypeHelp: Codable, Equatable {
        var type: TypeName
    
        struct TypeName: Codable, Equatable {
            var name: String
        }
    }
    
    
}

struct PokemonSearchResults: Codable, Equatable {
    var results: [Pokemon]
}

//array.joined(separator:"-")
