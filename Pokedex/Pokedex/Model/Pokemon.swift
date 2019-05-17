//
//  Pokemon.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: String
    let types: String
    let image: String
    
}

struct PokemonSearch: Codable {
    
    let results: [Pokemon]
}
