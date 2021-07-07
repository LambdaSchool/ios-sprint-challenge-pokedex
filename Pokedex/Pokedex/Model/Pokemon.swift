//
//  Pokemon.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    var types: [TypeSlot]
    var abilities: [AbilitySlot]
    var sprites: Sprites
    var imageData: Data?
    
    init(name: String, id: Int, types: [TypeSlot], abilities: [AbilitySlot], sprites: Sprites, imageData: Data? = nil) {
        (self.name, self.id, self.types, self.abilities, self.sprites, self.imageData) = (name, id, types, abilities, sprites, imageData)
    }
}

struct Pokedex: Codable, Equatable {
    var pokemon: [Pokemon]
}

struct Ability: Codable, Equatable {
    var name: String
}

struct AbilitySlot: Codable, Equatable {
    var ability: Ability
}

struct Type: Codable, Equatable {
    var name: String
}

struct TypeSlot: Codable, Equatable {
    var type: Type
}

struct Sprites: Codable, Equatable {
    var frontDefault: URL
}

