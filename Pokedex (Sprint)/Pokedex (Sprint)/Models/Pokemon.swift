//
//  Pokemon.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct Abilities: Codable {
    let ability: AbilityNames
}

struct AbilityNames: Codable {
    let name: String
}

struct Types: Codable {
    let type: PokeTypeName
}

struct PokeTypeName: Codable {
    let name: String
}

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: Abilities
    let type: Types
}
