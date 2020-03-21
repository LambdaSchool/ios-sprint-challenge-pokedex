//
//  Pokemon.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var id: Int
    var type: String
    var abilities: [String]
}
