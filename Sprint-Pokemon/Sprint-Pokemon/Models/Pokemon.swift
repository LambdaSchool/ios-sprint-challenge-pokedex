//
//  Pokemon.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokeType]
    let sprites: Sprite
}
struct Ability: Codable {
    let ability: Ability
    
    struct Ability: Codable {
        let name: String
    }
}
struct PokeType: Codable {
    let type: PokeType
    
    struct PokeType: Codable {
        let name: String
    }
}
struct Sprite: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_shiny"
    }
}

