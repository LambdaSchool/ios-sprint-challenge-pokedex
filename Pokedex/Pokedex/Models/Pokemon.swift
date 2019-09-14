//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vici Shaweddy on 9/13/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

struct PokemonAbility: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
    
    enum AbilityKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let ability = try values.nestedContainer(keyedBy: AbilityKeys.self, forKey: .ability)
        name = try ability.decode(String.self, forKey: .name)
    }
}

struct PokemonType: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    enum TypeKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        name = try type.decode(String.self, forKey: .name)
    }
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let abilities: [PokemonAbility]
}
