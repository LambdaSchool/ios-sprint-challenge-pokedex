//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [TypeElement]
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience
        case forms
        case gameIndices
        case height
        case heldItems
        case id
        case isDefault
        case locationAreaEncounters
        case moves, name, order, species, sprites, stats, types, weight
    }
    
    init(from decoder: Decoder) throws {
        <#code#>
    }
}

struct Ability: Codable {
   
    
}

struct TypeElement: Codable {
    
}
