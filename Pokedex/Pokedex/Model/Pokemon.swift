//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [String]
    let abilities: String
    let front_default: String
}
