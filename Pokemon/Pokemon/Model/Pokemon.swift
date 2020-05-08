//
//  Pokemon.swift
//  Pokemon
//
//  Created by Cody Morley on 5/8/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//
import Foundation

struct Pokemon: Codable {
    
    var name: String
    var id: Int
    var types: [TypeRoot]
    var abilities: [AbilityRoot]
    var sprites: Sprites
    
}

struct TypeRoot: Codable {
    var type: Types
}

struct AbilityRoot: Codable {
    var ability: Ability
}

struct Sprites: Codable {
    var front_default: String
}

struct Types: Codable {
    var name: String
}

struct Ability: Codable {
    var name: String
}
