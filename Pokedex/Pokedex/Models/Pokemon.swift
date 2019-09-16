//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Types]
    let sprites: [String]
}

struct Types: Decodable {
    let type: Type
}

struct Type: Decodable {
    let name: String
}

struct Abilities: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
}
