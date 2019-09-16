//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    let weight: Int
    let sprites: Sprites
    var imageData: Data?
    
    var allAbilities: String {
        let abilitiesList = abilities.map { $0.ability.name }
        return abilitiesList.joined(separator: ", ")
    }
    
    var allTypes: String {
        let typesList = types.map {$0.type.name}
        return typesList.joined(separator: ", ")
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}

struct SearchResults: Codable {
    let results: [Pokemon]
}

struct Ability: Codable, Equatable {
    let name: String
}

struct Abilities: Codable, Equatable {
    let ability: Ability
}

struct Type: Codable, Equatable{
    let name: String
}

struct Types: Codable, Equatable {
    let type: Type
}

struct Sprites: Codable, Equatable {
    let frontDefault: String
}
