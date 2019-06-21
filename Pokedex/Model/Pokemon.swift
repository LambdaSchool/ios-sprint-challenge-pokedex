//
//  File.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Types]
    let sprites: Sprites
    
    
    struct Ability: Codable {
        let ability: AbilityDetail
    }
    
    struct AbilityDetail: Codable {
        let name: String
    }
    
    struct Types: Codable {
        let type: TypeDetail
    }
    
    struct TypeDetail: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let front_default: String
    }
    
}



