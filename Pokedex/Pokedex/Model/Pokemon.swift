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
    let backFemale, backShinyFemale, backDefault, frontFemale: String
    let frontShinyFemale, backShiny, frontDefault, frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
        case backDefault = "back_default"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}

