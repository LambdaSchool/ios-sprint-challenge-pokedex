//
//  Pokemon.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case sprites
        case types
        
        enum AbilitiesDescriptionsKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum TypesDescriptionsKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
    }
    
    let name: String
    let id: Int
    let abilities: [String]
    let sprites: String
    var types: [String]
    
    init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(String.self, forKey: .sprites)
              
        let idString = try container.decode(String.self, forKey: .id)
        id = Int(idString) ?? 0
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        while abilitiesContainer.isAtEnd == false {
            let abilitiesDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilitiesDescriptionsKeys.self)
            
            let abilityContainer = try abilitiesDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilitiesDescriptionsKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        abilities = abilityNames
        var typeNames: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        while typesContainer.isAtEnd == false {
        let typesDescriptionContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypesDescriptionsKeys.self)
        
        let typeContainer = try typesDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilitiesDescriptionsKeys.AbilityKeys.self, forKey: .type)
        
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        types = typeNames
    }
    
    struct PokemonSearch: Codable {
        let results: [Pokemon]
    }
}
