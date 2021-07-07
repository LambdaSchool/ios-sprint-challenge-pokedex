//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {

    let id: Int
    let name: String

    let abilities: [Ability]

    let types: [TypeElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case abilities
        case types
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Ability: Codable {
    let ability: Species
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
    let name: String
}
