//
//  Pokemon.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
//    let sprites: String
    let id: Int
//    let types: String
//    let abilities: String
}

struct Abilities: Codable, Equatable {
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Codable, Equatable {
    let nameAbility: String
    
}

struct Types {
    let type: String
    let nameType: String
    
}
