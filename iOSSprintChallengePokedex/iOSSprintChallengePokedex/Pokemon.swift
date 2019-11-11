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

struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let types: [Types]
    let abilities: [Abilities]
    let sprite: Sprite
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name 
    }
}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct Types: Codable {
    let type: Type
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

