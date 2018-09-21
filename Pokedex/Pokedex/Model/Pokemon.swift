//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Abilities: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct Types: Codable, Equatable {
    let type: Type
    
}

struct Type: Codable, Equatable {
    let name: String
}
