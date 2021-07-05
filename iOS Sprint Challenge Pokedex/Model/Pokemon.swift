//
//  Pokemon.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    var name: String
    var id: Int
    var abilities: [Abilities]
    var types: [Types]
    let sprites: Sprite

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

struct Sprite: Codable {
    let frontDefault: URL
}
