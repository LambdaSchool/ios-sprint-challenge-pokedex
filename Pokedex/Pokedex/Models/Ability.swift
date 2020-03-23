//
//  Ability.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import Foundation

struct Ability: Codable, Equatable {
    let ability: PokemonAbility
}

struct PokemonAbility: Codable, Equatable {
    let name: String
    let id: Int
}
