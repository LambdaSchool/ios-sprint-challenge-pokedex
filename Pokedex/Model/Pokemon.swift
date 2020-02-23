//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kat Milton on 7/12/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Types]
    let sprites: Sprites
    
    // gather abilities array
    struct Ability: Codable {
        let ability: AbilityDetail
    }
    // get details of abilities
    struct AbilityDetail: Codable {
        let name: String
    }
    
    // get types array
    struct Types: Codable {
        let type: TypeDetail
    }
    
    // get details of types
    struct TypeDetail: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let front_default: String
    }
    
}
