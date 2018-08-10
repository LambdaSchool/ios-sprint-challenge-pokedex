//
//  Pokemon.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    
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
    
}
