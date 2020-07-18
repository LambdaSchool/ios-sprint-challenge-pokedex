//
//  Pokemon.swift
//  Pokedex
//
//  Created by Norlan Tibanear on 7/17/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [String]
    let types: [String]
    let sprites: String
    
    enum PokemonKeys: String, CodingKey {
        case name
        case id
        case abilities
        case types
        case sprites
        
        enum AbilitiyDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum TypeDescriptionKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
        }
    }//
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        var abilityNames: [String] = []
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        while !abilitiesContainer.isAtEnd {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilitiyDescriptionKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.AbilitiyDescriptionKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        var typesNames: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        while !typesContainer.isAtEnd {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.self)
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typesNames.append(typeName)
        }
        
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.sprites = try spriteContainer.decode(String.self, forKey: .sprite)
        self.abilities = abilityNames
        self.types = typesNames
        
    }//
    
    init(name: String, id: Int, abilities: [String], types: [String], sprites: String) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }
    
    
} //
