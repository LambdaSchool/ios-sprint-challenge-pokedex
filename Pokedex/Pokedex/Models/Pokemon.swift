//
//  Pokemon.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprite: Sprite
    let types: [Types]
    let abilities: [Abilities]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sprite = "sprites"
        case types = "types"
        case abilities = "abilities"
    }
    
}
