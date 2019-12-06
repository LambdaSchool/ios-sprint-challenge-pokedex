//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
   let name: String
   let id: Int
   let sprite: Sprite
   let type: [Type]
   let abilities: [Ability]
}

struct Sprite: Codable  {
    let frontDefault: URL
}

struct Type: Codable, Equatable {
    let type: Species
}

struct Species: Equatable, Codable {
    let name: String
}

struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
}
