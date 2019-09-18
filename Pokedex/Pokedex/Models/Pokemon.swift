//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    
    // Need to make these dictionaries.
    let types: [String:String]
    let abilities: [String:String]
    let sprites: String
}
