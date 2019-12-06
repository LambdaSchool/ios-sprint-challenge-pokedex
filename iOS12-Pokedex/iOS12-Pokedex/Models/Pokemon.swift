//
//  Pokemon.swift
//  iOS12-Pokedex
//
//  Created by Patrick Millet on 12/6/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let type: String
    let abilities: String
}
