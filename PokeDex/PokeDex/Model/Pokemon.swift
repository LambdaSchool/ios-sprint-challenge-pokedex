//
//  Pokemon.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Decodable {
    let name: String
    let id: Int
    let abilities: [Ability]
    struct Ability: Equatable, Decodable {
        let ability: SubAbility
        struct SubAbility: Equatable, Decodable {
            let name: String
        }
    }
    let sprites: Sprite
    struct Sprite: Equatable, Decodable {
        let frontDefault: String
    }
    let types: [PokemonType]
    struct PokemonType: Equatable, Decodable {
        let type: SubPokemonType
        struct SubPokemonType: Equatable, Decodable {
            let name: String
        }
    }
}

