//
//  Abilities.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Ability: Codable {
    let name: String
    let url: String
}

struct Abilities: Codable {
    let abilities: [Ability]
    let is_hidden: Bool
    let slot: Int
}
