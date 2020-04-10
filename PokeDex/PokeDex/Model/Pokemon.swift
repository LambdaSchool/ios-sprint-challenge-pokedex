//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String?
    var id: Int?
    var abilities: [PokemonAbility]?
    var types: [PokemonType]?
    var sprites: PokemonSprites?
    
    struct PokemonSprites: Codable {
        var frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    struct PokemonAbility: Codable {
        var ability: NamedAPIResource
        
        enum CodingKeys: String, CodingKey {
            case ability
        }
    }
    
    struct NamedAPIResource: Codable {
        var name: String
    }
    
    struct PokemonType: Codable {
        var type: NamedAPIResource
        
        enum CodingKeys: String, CodingKey {
            case type
        }
    }
}


struct PokemonSearchResults: Decodable {
    var results: Pokemon
}
