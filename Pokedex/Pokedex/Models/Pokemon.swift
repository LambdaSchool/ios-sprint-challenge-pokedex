//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jordan Christensen on 9/6/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Type]
}

struct Ability: Codable {
    var name: String
}

struct Type: Codable {
    var name: String
}
