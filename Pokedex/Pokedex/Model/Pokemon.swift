//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class Pokemon {
    var name: String
    var id: String
    var types: String
    var abilities: String
    
    init(name: String, id: String, types: String, abilities: String) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
    }
    
}
