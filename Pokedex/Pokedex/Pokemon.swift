//
//  Pokemon.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 14/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    var sprites: PokemonSprites
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
}

struct PokemonAbility: Codable {
    let ability: NamedAbility
}

struct NamedAbility: Codable {
    let name: String
}

struct PokemonType: Codable {
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    var picture: URL
    
    enum CodingKeys: String, CodingKey {
        case picture = "front_default"
    }
}
