//
//  Type.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import Foundation

struct Type: Codable, Equatable {
    let type: PokemonType
}

struct PokemonType: Codable, Equatable {
    let name: String
    let id: Int
}
