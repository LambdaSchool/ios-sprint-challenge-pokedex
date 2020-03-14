//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
 
struct Pokemon: Codable {
    var name: String
    var id: Int?
    var ability: Abilities?
    var type: Type?
    var image: Image?
    

}

//struct PokemonSprite: Codable {
//    let name: String
//
//    enum CodingKeys: String, CodingKey {
//        case name = "front_default"
//    }
struct Type: Codable {
    var name: [String] = []
}

struct Abilities: Codable {
    var name: [String] = []
}

struct Image: Codable {
    var defaultImage: String
    var url: String = "http://pokeapi.co/media/sprites/pokemon/"
    
    enum CodingKeys: String, CodingKey {
        case defaultImage = "front_default"
    }
}

struct PokemonSearchResults: Codable {
    var results: Pokemon
}
