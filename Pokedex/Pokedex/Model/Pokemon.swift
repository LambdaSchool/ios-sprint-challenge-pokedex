//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [String]
    let types: [String]
}
