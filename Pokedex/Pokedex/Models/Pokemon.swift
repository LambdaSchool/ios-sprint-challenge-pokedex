//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bradley Diroff on 3/13/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var abilities: [ability]
    var types: [type]
    var forms: [form]
    var id: Int
}
