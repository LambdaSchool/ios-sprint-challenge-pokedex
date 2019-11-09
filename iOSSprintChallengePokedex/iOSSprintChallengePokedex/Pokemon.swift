//
//  Pokemon.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation


//id
//The default depiction of this item.
//integer

//name
//The name for this resource.
//string

//types
//A list of details showing types this Pokémon has.
//list PokemonType

//abilities
//A list of abilities this Pokémon could potentially have.
//list PokemonAbility

//sprites
//A set of sprites used to depict this Pokémon in the game.
//PokemonSprites

struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let types: [Type]
    let abilities: [Ability]
    let sprite: Sprite
}

struct Ability: Codable {
    let name: String
}

struct Type: Codable {
    let name: String
}

struct Sprite: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default:"
    }
}

