//
//  Pokemon.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Decodable {
    
    let id: Int
    let name: String
    let abilities: [AbilityName]
    let types: [Types]
    let picture: Picture
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case picture = "sprites"
    }
}

struct AbilityName: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
}

struct Types: Decodable {
    let type: Type
}

struct Type: Decodable {
    let name: String
}

struct Picture: Decodable {
    let url: String
    
    enum SpriteKey: String, CodingKey {
        case url = "front_default"
    }
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
