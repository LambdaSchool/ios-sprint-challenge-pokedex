//
//  Pokemon.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Type]
    let image: Data
}

struct ConvenientToSavePokemon {
    let name: String
    let id: Int
    let abilities: String
    let types: String
    let image: Data
}
