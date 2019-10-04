//
//  Pokemon.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Type]
}
