//
//  Pokemon.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let sprites: Sprite
    let id: String
    let types: [Type]
    let abilities: [Ability]
}
