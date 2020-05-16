//
//  Pokemon.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Types]
    let sprites: Sprites
    var image: Data?
}

struct Ability: Codable {
    let ability: AbilityName
}

struct AbilityName: Codable {
    let name: String
}

struct Types: Codable {
    let type: TypeName
}

struct TypeName: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String
}
