//
//  Pokemon.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

struct Pokemon: Decodable, Equatable {

    let name: String
    let id: Int
    let abilities: [Ability]

    struct Ability: Decodable, Equatable {
        let ability: SubAbility

        struct SubAbility: Decodable, Equatable {
            let name: String
        }
    }
    let sprites: Sprite
    struct Sprite: Decodable, Equatable {
        let frontDefault: String
    }
    let types: [Types]
    struct Types: Decodable, Equatable {
        let type: SubType
        struct SubType: Decodable, Equatable {
            let name: String
        }
    }
}
