//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ngozi Ojukwu on 8/17/18.
//  Copyright © 2018 iyin. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let pokeAbilities: String?
    let pokeTypes: String?
    let abilities:[Ability]?
    let types: [pType]?
    
    init(name: String, id: Int, ability: String, type: String) {
        self.name = name
        self.id = id
        self.pokeAbilities = ability
        self.pokeTypes = type
        self.abilities = nil
        self.types = nil
    }
    
    
    struct Ability: Codable, Equatable{
        let ability: trueAbility
        struct trueAbility: Codable, Equatable{
            let name:String
        }
        
    }
    
    
    struct pType: Codable, Equatable {
        let type:trueType
        struct trueType: Codable,Equatable{
            let name: String
        }
    }
    
}

struct Abilities: Codable {
    
}

