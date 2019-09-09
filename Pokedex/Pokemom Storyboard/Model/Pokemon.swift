//
//  Pokemon.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [Pokemon]
}


struct Pokemon: Equatable, Codable {
  
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let abilities: [Ability]
      let id: Int
}

struct Ability: Equatable, Codable {
    let ability: Species
}

struct Species: Equatable, Codable {
    let name: String
}

struct Sprites: Equatable, Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Equatable, Codable {
    let type: Species
}
