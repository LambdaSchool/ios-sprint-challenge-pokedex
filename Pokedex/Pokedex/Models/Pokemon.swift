//
//  Pokemon.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprite
    //types
    //abilities
}

struct Sprite: Codable {
    let back_default: String
}
