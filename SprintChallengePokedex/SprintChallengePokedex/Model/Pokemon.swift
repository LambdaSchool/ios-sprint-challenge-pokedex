//
//  Pokemon.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    
    let types: [Types]
    struct Types: Codable {
        let type: Type
        struct `Type`: Codable {
            let name: String
        }
    }
    
    let abilities: [Abilities]
    struct Abilities: Codable {
        let ability: Ability
        struct Ability: Codable {
            let name: String
        }
    }
    
    let sprites: Sprites
    struct Sprites: Codable {
        let frontDefault: String
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}









