//
//  Pokemon.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


struct Pokemon: Equatable, Encodable, Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let abilities: [Ability]
    
}

struct Ability: Equatable, Encodable, Decodable {
    let ability: Species
}

struct Species: Equatable, Encodable, Decodable {
    let name: String
}

struct Sprites: Equatable, Encodable, Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey, Decodable {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Equatable, Encodable, Decodable {
    let type: Species
}
