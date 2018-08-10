//
//  Pokemon.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
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

/*
 init(name: String, id: String, abilities: String, types: String) {
 self.name = name
 self.id = id
 self.abilities = abilities
 self.types = types
 }
 
 required init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 
 //Decode name and id and set as respective Pokemon properties
 let name = try container.decode(String.self, forKey: .name)
 let id = String( try container.decode(Int.self, forKey: .id))
 
 let abilities = "Placeholder"
 let types = "Placeholder"
 // 4
 self.name = name
 self.id = id
 self.abilities = abilities
 self.types = types
 }
 
 static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
 return lhs.name == rhs.name &&
 lhs.id == rhs.id &&
 lhs.abilities == rhs.abilities &&
 lhs.types == rhs.types
 
 }
 */
