//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

//class Pokemon {
//    var name: String
//    var id: Int
//    var types: String
//    var abilities: String
//
//    init(name: String, id: String, types: String, abilities: String) {
//        self.name = name
//        self.id = id
//        self.types = types
//        self.abilities = abilities
//    }
//
//}

class Pokemon {
    var name: String?
    var id: Int
    var abilities: [String]
    var types: [String]
    
    init(name: String, id: Int, abilities: [String], types: [String]) {
        self.name = name; self.id = id; self.abilities = abilities; self.types = types
    }
}
//struct PokemonModel: Codable {
//    let name: String
//    let id: Int
//    let abilities: [PokemonAbility]
//    let types: [PokemonType]
//    let sprites: [PokemonSpriteName]
//
//    struct PokemonSpriteName: Codable {
//        let frontDefault: String
//    }
//
//    struct PokemonAbility: Codable {
//        let ability: [PokemonAbilityNames]
//
//        struct PokemonAbilityNames: Codable {
//            let name: String
//            let url: String
//        }
//    }
//    struct PokemonType: Codable {
//        let type: [PokemonTypeNames]
//
//        struct PokemonTypeNames: Codable {
//            let name: String
//        }
//    }
//}
