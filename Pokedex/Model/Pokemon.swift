//
//  Pokemon.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation


// Pokemon's name, ID, ability, and types.
struct Pokemon:Codable {
    
    let name: String
    let ID: String
    let ability: String
    let types: String
    
}
