//
//  Pokemon.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityArray]
    let types: [TypeArray]
}

struct AbilityArray: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct TypeArray: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
