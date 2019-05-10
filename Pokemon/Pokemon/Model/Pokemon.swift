//
//  Pokemon.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityArray]
    let sprities: Sprite
    let types: [TypeArray]
}

struct AbilityArray: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Sprite: Codable {
    let imageURL: String  //will have to use the special jsond decoding, snakeCase
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}

struct TypeArray: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
