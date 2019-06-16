//
//  Pokemon.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let abilities: [String]
    let id: Int
    let type: [String]
    
}
