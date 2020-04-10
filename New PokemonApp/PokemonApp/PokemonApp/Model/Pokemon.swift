//
//  Pokemon.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation
import UIKit


struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [PokemonAbilityWrapper]
    let sprites: PokemonSprites
    let types: [PokemonTypeWrapper]
}

struct PokemonSprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
      
    }

}

struct PokemonTypeWrapper: Codable {
    let type: PokemonType
}
struct PokemonType: Codable {
    let name: String
}

struct PokemonAbilityWrapper: Codable {
    let ability: PokemonAbility
}

struct PokemonAbility: Codable {
    let name: String
}
