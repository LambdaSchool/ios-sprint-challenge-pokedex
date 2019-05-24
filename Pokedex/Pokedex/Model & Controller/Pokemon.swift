//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jordan Davis on 5/24/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let sprites: Sprites
    let types: [TypeElement]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
}

struct Sprites: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey{
        case imageURL = "front_default"
    }
    
}

struct TypeElement: Codable {
    let type: Species
}

struct Type: Codable {
    let name: String
}
