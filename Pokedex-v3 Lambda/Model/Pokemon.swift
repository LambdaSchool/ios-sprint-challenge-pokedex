//
//  Pokemon.swift
//  Pokedex-v3
//
//  Created by Austin Potts on 9/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprite
    let types: [Type]
    
}

struct Sprite: Decodable {
    let frontDefault: URL
    
}

//struct Ability: Equatable, Codable {
//    let ability: Species
//}

struct Type: Decodable, Equatable {
    let type: Species
}

struct Species: Equatable, Codable {
    let name: String
}

