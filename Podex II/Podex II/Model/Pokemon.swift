//
//  Pokemon.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
struct Pokemon: Codable {
    let id: Int
    let name: String
    let baseExperience, height: Int?
    let order, weight: Int?
    let abilities: [Ability]
    let species: Species?
    let sprites: Sprites?
    let types: [TypeElement]
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let backFemale, backShinyFemale, backDefault, frontFemale: String?
    let frontShinyFemale, backShiny, frontDefault, frontShiny: String?
    
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
    let type: Species
}
