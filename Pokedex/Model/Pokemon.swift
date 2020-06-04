//
//  Pokemon.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

struct Pokemon:Codable {
    let name: String
    let ID: String
    let ablities: Abilities
    let types: Types
    let imageURL : String
}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
