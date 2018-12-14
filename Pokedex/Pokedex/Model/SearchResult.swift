//
//  SearchResult.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var name: String
    var id: String
    var types: String
    var abilities: String
}

// Structure to collect the full result
//Customize the results we want
struct PokemonResults: Codable {
    var results: [SearchResult]
}
