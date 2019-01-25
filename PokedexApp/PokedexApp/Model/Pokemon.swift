//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var abilities: [Abilities]
    var types: [TypeElement]
    var sprites: Sprites
}

struct Abilities: Codable {
    var ability: Species
}
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
     let name: String
}

struct Sprites: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
