//
//  Pokemon.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import UIKit

class Pokemon: Codable {
    
    enum Keys: String, CodingKey {
        case name
        case id
        case abilities
        case type
        case image
        
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
    
    
    let name: String
    let id: Int
    let abilities: [String]
    let types: [String]
    let image: String
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        // i know i have to fix the int
        id = try container.decode(Int.self, forKey: .id)
        
        image = try container.decode(String.self, forKey: .image)
        
        var abiltiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        var typeContainer = try container.nestedUnkeyedContainer(forKey: .type)
        
        var typeNames: [String] = []
        
        while abiltiesContainer.isAtEnd == false {
            
            let AbilityDescriptionContainer = try abiltiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try AbilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
            
            while typeContainer.isAtEnd == false {
                
                let TypeDescriptionContainer = try typeContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.self)
                
                let typeContainer = try TypeDescriptionContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
                
                let typeName = try typeContainer.decode(String.self, forKey: .name)
                typeNames.append(typeName)
                
            }
        }
        
        abilities = abilityNames
        types = typeNames
        
    }
    
}

