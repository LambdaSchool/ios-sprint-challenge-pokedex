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

    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Types]
    let sprites: Sprite
    var imageData: Data?





    struct Name: Codable {
        let name: String
    }


    struct Ability: Codable {
        let name: Name
    }


    struct Types: Codable {
        let name: Name
    }


    struct Sprite: Codable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
