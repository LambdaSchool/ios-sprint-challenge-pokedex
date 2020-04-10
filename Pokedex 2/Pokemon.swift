//
//  Pokemon.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    enum PokemonCodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case sprites
        
    }
    
    
    let id: Int
    let name: String
    let abilities: [Abilities]
    
}

struct Abilities: Codable {
    
    var ability: String
    
    enum AbilityCodingKeys: String, CodingKey {
        case ability
        
        enum AbilityNameCodingKeys: String, CodingKey {
            case secondName = "name"
        }
        
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbilityCodingKeys.self)
        self.ability = try container.decode(String.self, forKey: .ability)
        
        let abilitiesContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.AbilityNameCodingKeys.self, forKey: ., forKey: .)
    }
}

