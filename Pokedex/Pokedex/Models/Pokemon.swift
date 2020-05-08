
//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let id: Int
    let types: [Types]
    let abilities: [Abilities]
    let sprites: Image


    struct Types: Codable {
        let type: Types

        struct Types: Codable {
            let name: String
        }
    }


    struct Abilities: Codable {
        let ability: AbilityName

        struct AbilityName: Codable {
            let name: String
        }
    }

    struct Image: Codable {
        let defaultImageURL: URL

        enum CodingKeys: String, CodingKey {
            case defaultImageURL = "front_default"
        }
    }

}
