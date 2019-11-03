//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let sprites: Sprite
}

struct Ability: Codable {
    let ability: Ability
    
    struct Ability: Codable {
        let name: String
    }
}

struct Sprite: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_shiny"
    }
}

