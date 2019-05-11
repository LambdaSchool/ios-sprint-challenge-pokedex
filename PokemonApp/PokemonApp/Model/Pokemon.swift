//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/10/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {

    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    let sprites: Sprite






    struct SubAbility: Codable, Equatable {
        let name: String
    }

    struct SubType: Codable, Equatable {
        let name: String
    }


    struct Ability: Codable, Equatable {
        let name: SubAbility
    }


    struct Types: Codable, Equatable {
        let name: SubType
    }


    struct Sprite: Codable, Equatable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
