//
//  Pokémon.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

struct Pokémon: Equatable, Codable {
    let id: Int
    let name: String
    let abilities: [[String]]
    let types: [[[String]]]
    let sprites: [String]
}
