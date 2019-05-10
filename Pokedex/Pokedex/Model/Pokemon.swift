//
//  Pokemon.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//
import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityElement]
    let sprites: Sprites
    let types: [TypeElement]
}

struct AbilityElement: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: TypeClass
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}

struct TypeClass: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}

