//
//  Pokemon.swift
//  Sprint3
//
//  Created by Victor  on 5/10/19.
//  Copyright © 2019 com.Victor. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites
    var spriteImage: Data?
    
    struct Abilities: Codable, Equatable {
        let ability: Ability
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    
    struct Types: Codable, Equatable {
        let type: AType
        struct AType: Codable, Equatable {
            let name: String
        }
    }
    
    struct Sprites: Codable, Equatable {
        let front_default: String
    }
    
}
