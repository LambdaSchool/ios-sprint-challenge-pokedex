//
//  Pokemon.swift
//  PokemonChallenge
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let sprites: PokemonSprite
    var imageData: Data?
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.imageData == rhs.imageData
    }
    
    struct PokeCodeable: Codable {
        let name: String
    }
    
    struct PokemonSprite: Codable {
        let frontDefault: String
    }
    
    struct PokemonAbility: Codable {
        let ability: PokeCodeable
    }
    
    struct PokemonType: Codable {
        let type: PokeCodeable
    }
}
