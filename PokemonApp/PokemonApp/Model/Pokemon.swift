//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [TypeElement]
    let sprites: Sprite

    struct Ability: Codable, Equatable {

        let isHidden: String
        let slot: Int
        let ability: Species

        enum CodingKeys: String, CodingKey {

            case isHidden = "is_hidden"
            case slot
            case ability
        }
    }

    struct TypeElement: Codable {
        let slot: Int
        let type: Species
    }

    struct Sprite: Codable, Equatable {

        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct Species: Codable, Equatable {
        let name: String
        let url: String
    }



}
