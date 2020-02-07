//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    
    let types: [Types]
    let abilities: [Abilities]
    let sprites: Sprite
    
}

struct Types: Codable {
    let type: Type
    
}

struct Type: Codable {
    let name: String
}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String
}


