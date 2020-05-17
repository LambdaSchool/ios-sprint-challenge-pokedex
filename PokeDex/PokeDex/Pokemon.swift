//
//  Pokemon.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case types
        
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum TypeDescriptionKeys: String, CodingKey {
            case types
            
            enum TypeKeys: String, CodingKey {
                case type
            }
        }
    }

    let name: String
    let id: String
    let abilities: [String]
    let types: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        
        while !abilitiesContainer.isAtEnd {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        self.abilities = abilityNames
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typeNames: [String] = []
        
        while !typesContainer.isAtEnd {
            let typesDescriptionContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.self)
            
            let typeContainer = try typesDescriptionContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.self, forKey: .types)
            
            let typeName = try typeContainer.decode(String.self, forKey: .types)
            typeNames.append(typeName)
        }
        self.types = typeNames
    }
}

struct PokemonSearch: Decodable {
    let results: [Pokemon]
}
