//
//  Pokemon.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [TypeElement]
    let imageURL: Sprites  


    enum CodingKeys: String, CodingKey {

        case name = "name"
        case id = "id"
        case abilities = "abilities"
        case types = "types"
        case imageURL = "sprites"
    }
}

// MARK: - Ability
struct Ability: Codable, Equatable {
    let ability: SubAbility

    enum CodingKeys: String, CodingKey {
        case ability
    }
}

// MARK: - Sprites
struct Sprites: Codable, Equatable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable, Equatable {
    let slot: Int
    let type: SubAbility
}

// MARK: - Species
struct SubAbility: Codable, Equatable {
    let name: String
}
