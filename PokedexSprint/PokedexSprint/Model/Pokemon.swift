//
//  Pokemon.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation
import UIKit

struct PokemonSearchResult: Codable, Equatable {
    
    let name: String
    let abilities: [String]
    let sprites: String
    let id: Int
    let types: [String]
    
    //Coding Keys
    enum Keys: String, CodingKey {
        case species
        case name
        case abilities
        case sprites
        case id
        case types
        
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
        }
        
        enum TypeDescriptionKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        //Creating the containers to hold the PokemonSearchResult Properties
        let container = try decoder.container(keyedBy: Keys.self)
        
        //Name
        name = try container.decode(String.self, forKey: .name)
        
        //Abilities
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        abilities = abilityNames
        
        //Types
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typesStrings: [String] = []
        
        while typesContainer.isAtEnd == false {
            let typesDescriptionContainer = try typesContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.self)
            
            let typeContainer = try typesDescriptionContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            
            let typeString = try typeContainer.decode(String.self, forKey: .name)
            typesStrings.append(typeString)
        }
        types = typesStrings
        
        //Sprites
        let spriteContainer = try container.nestedContainer(keyedBy: Keys.SpriteKeys.self, forKey: .sprites)
        sprites = try spriteContainer.decode(String.self, forKey: .sprite)
        
        //ID
        id = try container.decode(Int.self, forKey: .id)
    }
    
    //Helper Method to get ability string out of array
    func getAbilitiesString() -> String{
        var string = "Abilities: "
        for ability in self.abilities {
            if ability == self.abilities.last || ability == self.abilities.first {
                string += "\(ability)"
            }
            string += ", \(ability)"
        }
        
        return string
    }
    
    //Helper Method to get type strings out of array
    func getTypesString() -> String {
        var string = "Types: "
        if self.types.count == 1 {
        if let typesFirst = self.types.first {
            return "Type: \(typesFirst)"
        }
        } else {
        for type in self.types {
            if type == self.types.last || type == self.types.first {
                print(type)
                string += "\(type)"
            }
            string += ", \(type)"
        }
    }
        return string
    }      
}

struct Pokemon: Codable, Equatable {
    let pokemonName : String
    let pokemonImageString : String
    let pokemonAbilities : [String]
    let id : Int
    let types: [String]
    
}

