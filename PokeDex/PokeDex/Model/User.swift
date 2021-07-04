//
//  User.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation

struct User: Equatable, Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Type]
    let sprites: Sprite
}

struct Ability: Equatable , Codable {
    let ability: Species
}

struct Type: Equatable , Codable {
    let type: Species
}


struct Species: Equatable , Codable {
    let name: String
}

struct Sprite: Equatable , Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }

}
