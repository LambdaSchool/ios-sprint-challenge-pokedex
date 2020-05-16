//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation



struct Pokemon: Decodable {
    
    enum PokemonCodinKeys: String, CodingKey {
        case id
        case name
        case abilities
        case sprites
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
    
    let id: Int
    let name: String
    let abilities: [String]
    let sprites: URL
    let types: [String]
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonCodinKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilitiesName: [String] = []
        while abilitiesContainer.isAtEnd == false {
            let abilitieDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonCodinKeys.AbilityDescriptionKeys.self)
            let abilityKeysContainer = try abilitieDescriptionContainer.nestedContainer(keyedBy: PokemonCodinKeys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityKeysContainer.decode(String.self, forKey: .name)
            abilitiesName.append(abilityName)
        }
        self.abilities = abilitiesName
        
        let spritesContainer = try container.nestedContainer(keyedBy: PokemonCodinKeys.SpriteKeys.self, forKey: .sprites)
        let spriteString = try spritesContainer.decode(String.self, forKey: .frontDefault)
        self.sprites = URL(string: spriteString)!
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typesArray: [String] = []
        while typesContainer.isAtEnd == false {
            let typeDescriptionKeyContainer = try typesContainer.nestedContainer(keyedBy: PokemonCodinKeys.TypeDescriptionKeys.self)
            let typeKeyContainer = try typeDescriptionKeyContainer.nestedContainer(keyedBy: PokemonCodinKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            let typeName = try typeKeyContainer.decode(String.self, forKey: .name)
            typesArray.append(typeName)
        }
        self.types = typesArray
        
    }
    
}

