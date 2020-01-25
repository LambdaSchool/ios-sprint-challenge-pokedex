//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

//Establish a Pokemon record with properties for the Pokemon's name, ID, ability, and types.

import Foundation
import UIKit

struct PokemonResults: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Equatable {
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: Image
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
    
}

struct AbilityInfo: Codable, Equatable {
    let ability: Ability

    struct Ability: Codable, Equatable {
        let name: String
    }
}

struct Image: Codable, Equatable {
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}

struct TypeInfo: Codable, Equatable {
    let type:TypieType

    struct TypieType: Codable, Equatable {
        let name: String
    }
}
