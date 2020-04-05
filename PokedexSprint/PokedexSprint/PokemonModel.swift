//
//  PokemonModel.swift
//  PokedexSprint
//
//  Created by Lambda_School_Loaner_241 on 3/26/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Decodable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [PokemonType]
    let sprites: Sprite
}

struct Ability: Equatable, Decodable {
    let ability: SubAbility
    
    struct SubAbility: Equatable, Decodable {
        let name: String
        
    }
    
}

struct PokemonType: Equatable, Decodable {
    let type: SubPokemonType
    
    struct SubPokemonType: Equatable, Decodable {
        let name: String
    }
}

struct Sprite: Equatable, Decodable {
    let frontDefault: String
    
}

