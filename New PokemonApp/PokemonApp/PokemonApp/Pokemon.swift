//
//  Pokemon.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String
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
    let name: String
    let url: String
}


