//
//  Pokemon.swift
//  pokedex sprint 3
//
//  Created by Rick Wolter on 11/1/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation


struct Pokemon: Equatable, Codable {
    
    let name: String
    let id: Int
   var type: [Types]
    var ability: [Abilities]
    let imageSprites: Sprites
    let imageData: Data?
    
    
    init(name: String, id: Int, type: [Types], ability: [Abilities], imageSprites: Sprites, imageData: Data? = nil) {
        
    self.name = name
        self.id = id
        self.type =  type
        self.ability = ability
        self.imageSprites = imageSprites
        self.imageData = imageData
        
    }
}




struct Pokedex: Codable, Equatable {
    var pokemon: [Pokemon]
}

struct Ability: Codable, Equatable {
    var name: String
}

struct Abilities: Codable, Equatable {
    var ability: Ability
}

struct Type: Codable, Equatable {
    var name: String
}

struct Types: Codable, Equatable {
    var type: Type
}

struct Sprites: Codable, Equatable {
    var frontDefault: URL
}

