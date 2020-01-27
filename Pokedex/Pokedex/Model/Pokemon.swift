//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

struct PokemonType: Codable {

}

struct PokemonAbility: Codable {
    
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let type: [PokemonType]
    let abilities: [PokemonAbility]
}
