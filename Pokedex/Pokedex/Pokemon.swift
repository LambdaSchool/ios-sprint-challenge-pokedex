//
//  Pokemon.swift
//  Pokedex
//
//  Created by Daniela Parra on 9/14/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: Int
    let types: [Types]
    let abilities: [Ability]
    
    struct Ability: Equatable, Codable {
        let ability: Name
        
        struct Name: Equatable, Codable {
            let name: String
        }
    }
    
    struct Types: Equatable, Codable {
        let type: Name
        
        struct Name: Equatable, Codable {
            let name: String
        }
    }
    
}
