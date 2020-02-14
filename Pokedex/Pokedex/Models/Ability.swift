//
//  Ability.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Ability: Codable {
    let name: String
}

struct Abilities: Codable {
    let ability: Ability
}
