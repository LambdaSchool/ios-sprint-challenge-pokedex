//
//  Pokemon.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name : String
    let id : Int // Pikachu ID : 25
    var abilities : [Ability]
    var types: [Type]
    var sprites: Dictionary<String, URL?> //sprite Pikachu URL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    
    // BASE IMG URL : https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/___.png
    
    init(name: String, id: Int, abilities: [Ability], types: [Type], sprites: Dictionary<String, URL?>){
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }
}

struct Ability: Codable {
    let name : String?
}

struct Type: Codable {
    let name : String?
}
