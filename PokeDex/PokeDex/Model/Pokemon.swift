//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String?
    var id: Int?
    var abilities: [PokemonAbility]?
    var types: [PokemonType]?
    var sprites: PokemonSprites?
    
    struct PokemonSprites: Decodable {
        var frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct PokemonAbility: Decodable {
        var ability: NamedAPIResource
        
        enum CodingKeys: String, CodingKey {
            case ability
        }
        struct NamedAPIResource: Decodable {
            var name: String
        }
    }

    struct PokemonType: Decodable {
        var type: NamedAPIResource
        
        enum CodingKeys: String, CodingKey {
            case type
        }
        struct NamedAPIResource: Decodable {
            var name: String
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case id
//        case abilities
//        case types
//        case sprites
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        name = try container.decode(String.self, forKey: .name)
//        id = try container.decode(Int.self, forKey: .id)
//        abilities = try container.decode([PokemonAbility].self, forKey: .abilities)
//        types = try container.decode([PokemonType].self, forKey: .types)
//        sprites = try container.decode(PokemonSprites.self, forKey: .sprites)
//
//    }
    
}




struct PokemonSearchResults: Decodable {
    var result: Pokemon
    
}
