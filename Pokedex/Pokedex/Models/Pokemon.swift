//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jordan Christensen on 9/6/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Type]
    var sprites: Sprites
}

struct Ability: Codable {
    var ability: AbilityDetail
}


struct AbilityDetail: Codable {
    var name: String
}

struct Type: Codable {
    var type: TypeDetail
}

struct TypeDetail: Codable {
    var name: String
}

struct Sprites: Codable {
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
    
    var frontImage: String
}

struct Poke: Codable {
    var name: String
    var id: Int
    var abilities: [Ability]
    var types: [Type]
    var image: Data
}
