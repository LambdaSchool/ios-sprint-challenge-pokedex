//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Austin Potts on 9/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


struct PokemonResult: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    
}
