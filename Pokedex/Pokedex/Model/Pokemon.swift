//
//  Pokemon.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    var name: String
    var id: Int
    var types: [TypeSlot]
    var abilities: [AbilitySlot]
    var sprites: Sprites
    
    init(name: String, id: Int, types: [TypeSlot], abilities: [AbilitySlot], sprites: Sprites) {
        (self.name, self.id, self.types, self.abilities, self.sprites) = (name, id, types, abilities, sprites)
    }
}

struct Ability: Codable {
    var name: String
}

struct AbilitySlot: Codable {
    var ability: Ability
}

struct Type: Codable {
    var name: String
}

struct TypeSlot: Codable {
    var type: Type
}

struct Sprites: Codable {
    var frontDefault: URL
}

