//
//  Pokemon.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var name: String
    var id: String
    var abilities: [PokemonAbilities]
    var types: [PokemonTypes]
}

struct PokemonAbilities: Equatable, Codable {
    var ability: [Ability]
}

struct Ability: Equatable, Codable {
    var name: String
}

struct PokemonTypes: Equatable, Codable {
    var types: [Type]
}

struct Type: Equatable, Codable {
    var name: String
}
