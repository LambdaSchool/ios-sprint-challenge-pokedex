//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let weight: Int
    let abilities: [AbilitySlot]
    let types: [TypeSlot]
    
    var abilityString: String {
        let abilitiesStrings = abilities.map { $0.ability.name }
        return abilitiesStrings.joined(separator: ", ")
    }
    
    var typesString: String {
        let typesStrings = types.map { $0.type.name }
        return typesStrings.joined(separator: ", ")
    }
}

struct AbilitySlot: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct TypeSlot: Codable, Equatable {
    let type: Type
}

struct Type: Codable, Equatable {
    let name: String
}
