//
//  Pokemon.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let sprites: Sprites
    let types: [Types]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case sprites
        case types
    }
}


struct Abilities: Codable {
    let ability: Ability
    let isHidden: Bool
    let slot: Int
    private enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Ability: Codable {
    let name: String
    let url: URL
}

struct Sprites: Codable {
    let backDefault: URL
    let backFemale: URL
    let backShiny: URL
    let backShinyFemale: URL
    let frontDefault: URL
    let frontFemale: URL
    let frontShiny: URL
    let frontShinyFemale: URL
    private enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct Types: Codable {
    let slot: Int
    let type: PokeType
}

struct PokeType: Codable {
    let name: String
    let url: URL
}
