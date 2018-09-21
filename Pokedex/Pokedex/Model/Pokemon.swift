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
    let abilities: [Abilities.Ability]
    let types: [Types.aType]

    struct Abilities: Codable, Equatable {
        
        struct Ability: Codable, Equatable {
            
            let name: String
        }
    }
    
    struct Types: Codable, Equatable {
        
        struct aType: Codable, Equatable {
            
            let name: String
        }
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}
