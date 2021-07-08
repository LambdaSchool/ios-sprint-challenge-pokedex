//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    var abilities: [Abilities]
    var types: [Types]
    var sprites: [Sprites]
    
    
    struct Abilities: Codable, Equatable {
        let ability: String
    }
    
    struct Types: Codable, Equatable {
        let type: String
    }
    
    struct Sprites: Codable, Equatable {
        let frontDefault: String
    }
    
}
