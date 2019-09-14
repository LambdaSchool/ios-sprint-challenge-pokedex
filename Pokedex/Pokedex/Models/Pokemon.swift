//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
//    let id: Int
    let name: String
//    let type: [Type]
//    let ability: [Ability]
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
}

struct Type: Codable {
    let slot: Int
    let details: Details
}

struct Ability: Codable {
    let slot: Int
    let details: Details
}

struct Details: Codable {
    let name: String
    let url: String
}
