//
//  Pokémon.swift
//  Pokédex
//
//  Created by Thomas Sabino-Benowitz on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    var id: Int
    var name: String
    var abilities: [Ability]
    var types: [Type]
    var sprites: Sprite
}

struct Sprite: Codable {
    let front_default: URL
}

struct Ability: Codable {
    let ability: Name
}

struct Name: Codable {
    let name: String
}

struct Type: Codable {
    var type: Name
}
