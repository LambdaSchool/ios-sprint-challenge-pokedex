//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Types]
    let sprites: Dictionary<String, URL?>
    
    init(id: Int, name: String, abilities: [Ability], types: [Types], sprites: Dictionary<String, URL?>) {
        self.id = id
        self.name = name
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }

    struct NestedString: Codable {
        let name: String?
    }
    
    struct Ability: Codable {
        let ability: NestedString?
    }

    struct Types: Codable {
        let type: NestedString?
    }
    
}
