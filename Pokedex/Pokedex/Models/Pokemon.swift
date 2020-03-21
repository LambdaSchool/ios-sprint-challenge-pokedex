//
//  Pokemon.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
//    let abilities: [PokemonAbility]
//    let types: [PokemonType]
}

struct PokemonAbility: Codable {
    let is_hidden: Bool
    let slot: Int
    let ability: Ability
}

struct Ability: Codable {
    let name: String
    let url: String
}

struct PokemonType: Codable {
    let slot: Int
    let type: Type
}

struct Type: Codable {
    let id: Int
    let name: String
}
