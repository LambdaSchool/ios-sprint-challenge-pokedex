//
//  Character.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let name: String
    let id: Int
    let types: [String]
    let abilities: [String]
    
    init(name: String, id: Int, types: [String] = [], abilities: [String] = []) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
    }
}

struct CharacterSearch: Decodable {
    let result: [Character]
}
