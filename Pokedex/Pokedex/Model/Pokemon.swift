//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let weight: Int
    let abilities: [Ability]
    let type: [Type]
}

struct Ability: Codable, Equatable {
    let name: String
    let id: Int
}

struct Type: Codable, Equatable {
    let name: String
    let id: Int
}
