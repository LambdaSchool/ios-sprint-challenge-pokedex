//
//  Pokemon.swift
//  Pokedex
//
//  Created by Joshua Rutkowski on 1/26/20.
//  Copyright © 2020 Josh Rutkowski. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    var name: String
    var id: Int
    var abilities: [AbilityContainer]
    var image: Data?
    var types: [TypeContainer]
    var sprites: SpriteContainer
    
}

struct Ability: Codable, Equatable{
    var name: String
}

struct AbilityContainer: Codable, Equatable {
    var ability: Ability
}

struct Types: Codable, Equatable {
    var name: String
}

struct TypeContainer: Codable, Equatable{
    var type: Types
}

struct SpriteContainer: Codable, Equatable {
    var frontDefault: String
}

