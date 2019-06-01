//
//  Pokemon.swift
//  Pokedex
//
//  Created by Michael Stoffer on 6/1/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var id: Int
    var name: String
    var abilities: [Ability]
    var types: [Type]
    var sprites: Image
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

struct Ability: Codable {
    var name: Species
}

struct Type: Codable {
    var name: Species
}

struct Species: Codable {
    var name: String
}

struct Image: Codable {
    var front_default: String
}
