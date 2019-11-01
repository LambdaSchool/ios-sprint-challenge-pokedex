//
//  Pokemon.swift
//  Pokedex
//
//  Created by brian vilchez on 11/1/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation
//struct Pokemon: Decodable {
//    let name: String
//    let id: Int
//    let Sprites: String
//    let abilities: [String]
//
//    enum PokemonKeys: String,CodingKey {
//        case name
//        case id
//        case sprites
//        case abilities
//
//        enum abilityKeys: String, CodingKey {
//            case abiility
//        }
//
//
//    }
//
//    init(fromDecoder decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: PokemonKeys.self)
//        let name = try container.decode(String.self, forKey: .name)
//        let id = try container.decode(Int.self, forKey: .id)
//        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
//        let sprites = try container.decode(String.self, forKey: .sprites)
//
//        var abilitiesList = [String]()
//        while !abilitiesContainer.isAtEnd {
//            let ability = try abilitiesContainer.decode(String.self)
//            abilitiesList.append(ability)
//        }
//
//        self.name = name
//        self.id = id
//        self.Sprites = sprites
//        self.abilities = abilitiesList
//    }
//}

struct Pokemon: Decodable {
    let name: String
    let id:Int
    let sprites: Sprite
    let abilities: [Ability]
    let types: [Type]
}

struct Abilities: Decodable {
    let abilities: Ability
}

struct Ability: Decodable {
    let ability: abilityName
}
struct Type: Decodable {
    let type: TypeName
}
struct TypeName: Decodable {
    let name: String
}
struct abilityName: Decodable {
    let name:String
}

struct Sprite: Decodable {
    let frontDefault: URL
}
