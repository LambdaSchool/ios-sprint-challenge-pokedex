//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 5/17/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: String
    let types: String
    let image: Data
}
