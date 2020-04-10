//
//  Pokemon.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case sprites
        case types
        case abilities
    }
    let name: String
    let id: Int
    let sprites: FrontDefault
    let types: [Type]
    let abilities: [Ability]
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.sprites = try container.decode(FrontDefault.self, forKey: .sprites)
        self.types = try container.decode([Type].self, forKey: .types)
        self.abilities = try container.decode([Ability].self, forKey: .abilities)
    }
}

// MARK: - Sprite

struct FrontDefault: Decodable {
    enum CodingKeys: String, CodingKey {
        case spriteURL = "frontDefault"
    }
    let spriteURL: String
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        spriteURL = try container.decode(URL.self, forKey: .spriteURL)
//    }
}

// MARK: - Types

struct Type: Decodable {
    let type: Name
}

struct Name: Decodable {
    let name: String
}

// MARK: - Abilites

struct Ability: Decodable {
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}
