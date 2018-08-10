//
//  Pokemon.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var id: Int
    let abilities: [PokemonAbilities]
    let types: [PokemonTypes]
}

struct PokemonTypes: Decodable {
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}

struct PokemonAbilities: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let url: String
    let name: String
}
