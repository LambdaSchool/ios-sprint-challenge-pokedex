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
    let locationAreaEncounters: String?
    let sprites: Sprite
    let types: [Type]
    let abilities: [Ability]
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case height
        case weight
        case locationAreaEncounters = "location_area_encounters"
        case sprites
        case types
        case abilities
    }

}
