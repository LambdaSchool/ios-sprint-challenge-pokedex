//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let ability: [Abilities]
    let types: [Types]
     let imageURL: String
}

struct Abilities: Codable {
    let is_hidden: Bool
    let slot: Int
    let name: String
    
}
struct Types: Codable {
    let name: String
}
