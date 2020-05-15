//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation


struct Pokemon : Codable {
    //pokemon: name, ID, ability, types
    let name: String
    let id: Int
    let sprites: String
    let abilities: [String]
    let types: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case sprites
        case abilities
        case types
        
        
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
        
        enum TypeDescriptionKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        id = try container.decode(Int.self, forKey: .id)
        
        let spriteContainer = try container.nestedContainer(keyedBy: CodingKeys.SpriteKeys.self, forKey: .sprites)
        sprites = try spriteContainer.decode(String.self, forKey: .frontDefault)
        
        //Ability
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.AbilityKeys.self , forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
            
        }
        
        abilities = abilityNames
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typesArray: [String] = []
        
        while typesContainer.isAtEnd == false {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.self)
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            
            typesArray.append(typeName)
            
        }
        types = typesArray
    }
}
