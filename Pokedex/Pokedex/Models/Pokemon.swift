//
//  Pokemon.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let sprites: Sprite
    let id: Int
    let types: [Type]
    let abilities: [Ability]
}
