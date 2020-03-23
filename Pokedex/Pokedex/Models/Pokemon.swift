//
//  Pokemon.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: [Type]
    let abilities: [Ability]
    let sprites: ImageAngle
}

struct Type: Codable {
    let type: TypeName
    
    struct TypeName: Codable {
        let name: String
    }
}

struct Ability: Codable {
    let ability: AbilityName
    
    struct AbilityName: Codable {
        let name: String
    }
}

struct ImageAngle: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
