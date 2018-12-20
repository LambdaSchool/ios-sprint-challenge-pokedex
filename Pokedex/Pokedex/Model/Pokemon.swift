//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    
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
}

struct SearchResults: Codable {
    let results: [Pokemon]
}

