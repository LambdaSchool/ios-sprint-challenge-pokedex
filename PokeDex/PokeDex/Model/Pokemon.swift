//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [TypeElement]
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience
        case forms
        case gameIndices
        case height
        case heldItems
        case id
        case isDefault
        case locationAreaEncounters
        case moves, name, order, species, sprites, stats, types, weight
    }
     
}

struct Ability {
    let ability: NamedResource

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden
        case slot
    }
}

struct NamedResource: Codable {
    let name: String
    let url: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: NamedResource
}

struct Sprites {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case backDefault
        case backFemale
        case backShiny
        case backShinyFemale
        case frontDefault = "front_default"
        case frontFemale
        case frontShiny
        case frontShinyFemale
    }
}

struct PokemonSearchResults: Codable {
    let results: Pokemon
}
