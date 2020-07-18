//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation

struct Pokemon : Codable, Equatable {

    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: SpriteFront


    struct AbilityInfo: Codable, Equatable {
        let ability: Ability

        struct Ability: Codable, Equatable {
            let name: String
        }
    }

    struct TypeInfo: Codable, Equatable {
        let type:TypieType

        struct TypieType: Codable, Equatable {
            let name: String
        }
    }


    struct SpriteFront: Codable, Equatable {
        let imageUrl: String

        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
        }
    }

}
