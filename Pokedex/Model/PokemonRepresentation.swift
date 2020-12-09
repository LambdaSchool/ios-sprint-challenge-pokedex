//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation

struct PokemonRepresentation: Codable {
    let id: Int
    let name: String
    let types: [String]
    let abilities: [String]
    let sprite: URL
    
    enum PokemonKeys: String, CodingKey {
        case id
        case name
        case types
        case abilities
        case sprites
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_shiny"
        }
        
        enum AbilityDescriptionKeys: String, CodingKey {
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
    }
}


extension PokemonRepresentation {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        id = try container.decode(Int.self, forKey: .id)
        
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        abilities = abilityNames
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typeNames: [String] = []
        while typesContainer.isAtEnd == false {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.self)
            
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        types = typeNames
    }
}
