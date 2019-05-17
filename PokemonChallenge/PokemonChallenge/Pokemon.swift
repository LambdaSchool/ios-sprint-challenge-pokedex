//
//  Pokemon.swift
//  PokemonChallenge
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation

import Foundation

class Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    var image: Data?
    let ability: [PokemonAbility]
    let type: [PokemonType]
    let sprites: PokemonSprite
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.image == rhs.image
    }
    
    struct PokeCodable: Codable {
        let name: String
    }
    
    struct PokemonSprite: Codable {
        let frontDefault: String
    }
    
    struct PokemonAbility: Codable {
        let ability: PokeCodable
    }
    
    struct PokemonType: Codable {
        let type: PokeCodable
    }
}
