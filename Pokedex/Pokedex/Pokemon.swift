//
//  Pokemon.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [AbilitiesArray]
    var types: [TypeObject]
}

class AbilitiesArray: Codable {
    let ability: AbilityItems
    
    init(ability: AbilityItems) {
        self.ability = ability
    }
    
    struct AbilityItems: Codable {
        var name: String
    }
}

class TypeObject: Codable {
    var type: TypeType
    
    init(type: TypeType) {
        self.type = type
    }
    
    struct TypeType: Codable {
        var name: String
    }
}
