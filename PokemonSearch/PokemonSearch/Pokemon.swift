//
//  Pokemon.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    var name: String
    var id: Int
    var abilities: [String] = []
    var types: [String] = []
}

struct PokemonSearchResults: Codable {
    var results: [Pokemon]
}

//array.joined(separator:"-")
