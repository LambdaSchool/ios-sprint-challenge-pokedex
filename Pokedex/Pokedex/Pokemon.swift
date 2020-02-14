//
//  Pokemon.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: String
    let types: [String]
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case imageURL = "sprites"
    }
}
