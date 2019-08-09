//
//  Pokemon.swift
//  ios-sprint-challenge-pokedex
//
//  Created by Alex Shillingford on 8/9/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let abilities: [AbilityElement]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

// MARK: - AbilityElement
struct AbilityElement: Codable {
    let ability: TypeClass
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault, frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}
