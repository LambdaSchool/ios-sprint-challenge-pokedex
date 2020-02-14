//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

import UIKit


struct Pokemon: Codable {
    
    var name: String
    var id: Int
    var abilities: [AbilityHolder]
    var sprite: SpriteHolder
    var type: [TypeHolder]
    var image: Data?
}


struct Ability: Codable, Equatable {
    var name: String
}

struct Types: Codable, Equatable {
    var name: String
}

struct AbilityHolder: Codable, Equatable {
    var ability: Ability
}

struct TypeHolder: Codable, Equatable {
    var type: Types
}

struct SpriteHolder: Codable, Equatable {
    var sprite: String
}
