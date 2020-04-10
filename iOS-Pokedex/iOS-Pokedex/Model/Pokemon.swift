//
//  Pokemon.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    //let count: Int
    //let next: String
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}


struct Pokemon1 {
    let name: String
    let url: String
}



//Testing
struct PokemonTesting: Codable {
    let abilities: [Ability]
    let forms: [Species]
    let id: Int
    let name: String
    let sprites: Sprites
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
    }
    
    let backDefault: String
}
