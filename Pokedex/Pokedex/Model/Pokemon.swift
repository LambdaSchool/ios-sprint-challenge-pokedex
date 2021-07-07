//
//  Pokemon.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 10/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

struct Pokemon: Codable
{
    let abilities: [Abilities]?
    let name: String?
    let id: Int?
    let types: [Types]?
    let sprites: Sprites?
    
    enum CodingKeys: String, CodingKey
    {
        case abilities = "abilities"
        case name = "name"
        case id = "id"
        case sprites = "sprites"
        case types = "types"
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abilities = try values.decodeIfPresent([Abilities].self, forKey: .abilities)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        sprites = try values.decodeIfPresent(Sprites.self, forKey: .sprites)
        types = try values.decodeIfPresent([Types].self, forKey: .types)
    }
    
    struct Sprites: Codable
    {
        let back_default: String?
        let front_default: String?
        
        enum CodingKeys: String, CodingKey
        {
            case back_default = "back_default"
            case front_default = "front_default"
        }
        
        init(from decoder: Decoder) throws
        {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            back_default = try values.decodeIfPresent(String.self, forKey: .back_default)
            front_default = try values.decodeIfPresent(String.self, forKey: .front_default)
        }
    }
    
    struct Types: Codable
    {
        let type: PokemonType?
        
        enum CodingKeys: String, CodingKey
        {
            case type = "type"
        }
        
        init(from decoder: Decoder) throws
        {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            type = try values.decodeIfPresent(PokemonType.self, forKey: .type)
        }
        
        struct PokemonType : Codable
        {
            let name: String?
            
            enum CodingKeys: String, CodingKey
            {
                case name = "name"
            }
            
            init(from decoder: Decoder) throws
            {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                name = try values.decodeIfPresent(String.self, forKey: .name)
            }
        }
    }
    
    struct Abilities: Codable
    {
        let ability: Ability?
        
        enum CodingKeys: String, CodingKey
        {
            case ability = "ability"
        }
        
        init(from decoder: Decoder) throws
        {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ability = try values.decodeIfPresent(Ability.self, forKey: .ability)
        }
        
        struct Ability: Codable
        {
            let name: String?
            
            enum CodingKeys: String, CodingKey
            {
                case name = "name"
            }
            
            init(from decoder: Decoder) throws
            {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                name = try values.decodeIfPresent(String.self, forKey: .name)
            }
        }
    }
}
