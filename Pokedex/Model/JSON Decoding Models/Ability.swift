//
//  Ability.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

struct Ability: Codable {
    let ability: PokemonNameAndURL
    let is_hidden: Bool
    let slot: Int
}
