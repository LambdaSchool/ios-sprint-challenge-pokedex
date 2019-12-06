//
//  Pokemon.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let imageURL: String
    let id: Int
    let types: String
    let abilities: String
}
