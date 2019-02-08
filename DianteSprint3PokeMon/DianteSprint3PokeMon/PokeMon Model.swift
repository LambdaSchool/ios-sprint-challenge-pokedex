//
//  PokeMon Model.swift
//  DianteSprint3PokeMon
//
//  Created by Diante Lewis-Jolley on 2/1/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites
    var imageData: Data?

    struct Types: Codable {
        let type: Name
    }

    struct Abilities: Codable {
        let ability: Name
    }

    struct Name: Codable {
        let name: String
    }

    struct Sprites: Codable {
        let frontDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
