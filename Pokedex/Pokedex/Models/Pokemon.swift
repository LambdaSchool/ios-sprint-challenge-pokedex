//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class Pokemon {
    var name: String?
    var id: Int
    var abilities: [String]
    var types: [String]
    
    init(name: String, id: Int, abilities: [String], types: [String]) {
        self.name = name; self.id = id; self.abilities = abilities; self.types = types
    }
}
