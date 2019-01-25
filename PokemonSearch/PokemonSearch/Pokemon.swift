//
//  Pokemon.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    var abilities: [String]
    var types: [String]
    
    init(name: String, id: Int, abilities: [String] = [], types: [String] = []) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }
}

struct PokemonSearchResults: Codable, Equatable {
    var results: [Pokemon]
}

//array.joined(separator:"-")
