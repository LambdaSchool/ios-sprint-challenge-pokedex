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
    var abilities: [Abilities]?
    var types: Types?
    var sprites: PokemonSprite
    

}

struct PokemonSprite: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "front_default"
    }
}

struct Types: Codable {
    var name: [String]
}

struct Abilities: Codable {
    var isHidden: Bool
    var slot: Int
    var ability = [Ability]()
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot = "slot"
        case ability = "ability"
    }
}

struct Ability: Codable {
    var name: String
    var url: String
}

struct PokemonSearchResults: Codable {
    var results: Pokemon

}
