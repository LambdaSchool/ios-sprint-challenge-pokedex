//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jerrick Warren on 10/26/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    let name: String
    let id: Int
    // image later
    
    private enum CodingKeys: String, CodingKey {
        case name, id
    }
    
    struct PokemonResults: Codable {
        var results: [Pokemon]
    }
    
}
