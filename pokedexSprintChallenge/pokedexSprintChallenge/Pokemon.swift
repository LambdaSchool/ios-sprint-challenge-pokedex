//
//  Pokemon.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    var image: Image
    var id: ID
    var type: Types
    var abilities: Abilities
}

struct Image: Codable {
    let sprites: URL
}

struct ID: Codable {
    let id: Int
}

struct Types: Codable {
    let types: String
}

struct Abilities: Codable {
    let abilities: String
}



