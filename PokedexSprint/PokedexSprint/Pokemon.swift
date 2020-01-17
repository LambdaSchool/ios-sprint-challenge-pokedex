//
//  Pokemon.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String?
    let id: Int?
    // abilities: [String] ???
    // sprites: -> front_default ???
    // type: [String] ???
}
