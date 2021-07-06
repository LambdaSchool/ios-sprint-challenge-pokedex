//
//  Pokemon.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    var name: String
    var id: Int
    var abilities: [String]
    var types: [String]
    var sprites: [String: String?]
    
    struct Ability: Equatable, Codable {
        var ability: String
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let abilityDictionary = try container.decode([String: String].self, forKey: .ability)
            
            self.ability = abilityDictionary["name"]!
        }
    }
    
    struct PokemonType: Equatable, Codable {
        var type: String
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let pokemonTypeDictionary = try container.decode([String: String].self, forKey: .type)
            
            self.type = pokemonTypeDictionary["name"]!
        }
    }
    
    init(from decoder: Decoder) throws {
        
        // 1
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        
        // This is an array of dictionaries
        let abilityObjects = try container.decodeIfPresent([Ability].self, forKey: .abilities)
        let pokemonTypeObjects = try container.decodeIfPresent([PokemonType].self, forKey: .types)
        
        let spriteNames = try container.decodeIfPresent([String: String?].self, forKey: .sprites)
        
        // 3
        let abilities = abilityObjects?.map { $0.ability } ?? []
        let types = pokemonTypeObjects?.map { $0.type } ?? []
        
        // 4
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = spriteNames ?? [:]
    }
}
