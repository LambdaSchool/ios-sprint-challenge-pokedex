//
//  Pokemon.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation
import UIKit




//struct Pokemon: Codable, Equatable {
//
//    var name: String?
//    var imageURL: String?
//    var id: String?
//    var type: String?
//    var ability: String?
//
//    private enum PokemonCodingKeys: String, CodingKey {
//        case name
//        case imageURL
//        case id
//        case type
//        case ability
//    }
//
//    init(decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: PokemonCodingKeys.self)
//        try container.decode(name, forKey: .name)
//    }
//}
//
//struct PokemonSearchResults: Codable {
//    let results: [Pokemon]
//}


struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [AbilityRoot]
    let types: [TypesRoot]
    let sprites: Sprites
}

struct TypesRoot: Codable {
    let type: Types
}

struct Types: Codable {
    let name: String
}

struct AbilityRoot: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String
}


