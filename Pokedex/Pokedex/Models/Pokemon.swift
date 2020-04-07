//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bree Jeune on 4/7/20.
//  Copyright © 2020 Young. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites


    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
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



struct Sprites: Codable {
    let front_default: String

}
