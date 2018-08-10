//
//  Pokemon.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var name: String
    var id: Int
    var types: [Pokemon.TypeArray.TheType]
    var allTypes: String?
    var abilities: [Pokemon.AbilitiesArray.Ability]
    var allAbilities: String?
    
    // Types
    struct TypeArray: Equatable, Codable {
        var type: Pokemon.TypeArray.TheType
            
        // Can't name it plain Type
        struct TheType: Equatable, Codable {
            var name: String
        }
    }
    
    // Abilities
    struct AbilitiesArray: Equatable, Codable {
        var ability: Pokemon.AbilitiesArray.Ability
        
        struct Ability: Equatable, Codable {
            var name: String
        }
    }
}
