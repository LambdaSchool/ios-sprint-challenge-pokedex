//
//  Pokemon.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

struct Pokemon: Codable{
    let name: String
    let id: Int
    let type: String
    let abilities: [String]
}
