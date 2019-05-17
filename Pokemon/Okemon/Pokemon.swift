//
//  Pokemon.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class Pokemon: Codable  {

    let name: String
    let id: Int

    let abilities: [Ability]
    let types: [Types]

    let sprites: [Sprite]

    init(name: String, id: Int, abilities: [Ability], types: [Types], sprites: [Sprite] ) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }

}
struct Name: Codable {
    let name: String
}
struct Ability: Codable {
    let ability: Name
}
struct Types: Codable {
    let type: Name
}
struct Sprite: Codable {
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    
    let frontDefault: String
}

