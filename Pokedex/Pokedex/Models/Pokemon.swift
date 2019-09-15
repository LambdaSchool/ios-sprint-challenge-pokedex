//
//  Pokemon.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityElement]
    let types: [TypeElement]
    let sprites: Sprites
}
