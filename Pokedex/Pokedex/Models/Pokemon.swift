//
//  Pokemon.swift
//  Pokedex
//
//  Created by Casualty on 9/15/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let height: Int
    let weight: Int
    let stats: [PokemonStat]
    let sprites: Sprite
    let types: [Type]
    let abilities: [Ability]

}
