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
    var abilities: [Pokemon.Ability] //does it need to be an array?
    var types: [Pokemon.TypeName]
    
    init(name: String, id: Int, abilities: [Pokemon.Ability] = [], types: [Pokemon.TypeName] = []) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }
    
    struct Ability: Codable, Equatable {
        var name: String
    }
    struct TypeName: Codable, Equatable {
        var name: String
    }
}

struct PokemonSearchResults: Codable, Equatable {
    var results: [Pokemon]
}

//array.joined(separator:"-")
