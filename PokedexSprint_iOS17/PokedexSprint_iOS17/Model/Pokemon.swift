//
//  Pokemon.swift
//  PokedexSprint_iOS17
//
//  Created by Stephanie Ballard on 5/8/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: Species
}
