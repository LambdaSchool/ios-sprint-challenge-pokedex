//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    let name: String
    let id: Int
    let types: [String]
    let abilities: [String]
    let imageURL: URL
    let imageData: Data?
    
    init(name: String, id: Int, types: [String], abilities: [String], imageURL: URL) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
        self.imageURL = imageURL
        self.imageData = nil
    }
}

struct APIAbility: Codable {
    let name: String
}

struct APIPokemonType: Codable {
    let type: [String : String]
}

struct APIPokemon: Codable {
    let name: String
    let id: Int
    let types: [APIPokemonType]
    let abilities: [APIAbility]
    let sprites: [String : String]
}
