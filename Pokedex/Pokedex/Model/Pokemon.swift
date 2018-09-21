//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: String
    let abilities: String
    let types: String
}

struct SearchResults: Codable {
    let results: [Pokemon]
}
