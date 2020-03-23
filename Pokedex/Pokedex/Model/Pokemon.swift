//
//  Pokemon.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import Foundation

//struct Pokemon: Codable {
//    let name: String
//    let id: Int
//    let abilities: String
//    let types: String
//    let sprites: String
//}

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokeType]
    let sprites: Sprite
}
struct Ability: Codable, Equatable {
    let ability: Ability
    struct Ability: Codable, Equatable {
        let name: String
    }
}
struct PokeType: Codable, Equatable {
    let type: PokeType
    struct PokeType: Codable, Equatable {
        let name: String
    }
}
struct Sprite: Codable, Equatable {
    let imageURL: String
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}
