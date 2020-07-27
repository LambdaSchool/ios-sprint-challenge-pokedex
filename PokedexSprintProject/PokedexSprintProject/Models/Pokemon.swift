//
//  Pokemon.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Decodable {
    
    //Coding Keys
    enum Keys: String, CodingKey {
        case name
        case id
        case types
        case abilities
        case imageURL = "sprites"
        
        
        enum TypeDescriptionKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
        
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpritesKey: String, CodingKey {
            case front_default
        }
        
    }
    
    var name: String
    var id: Int
    var types: [String]
    var abilities: [String]
    var imageString: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        id = try container.decode(Int.self, forKey: .id)
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        var typeNames: [String] = []
        
        while typesContainer.isAtEnd == false {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.self)
            
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        
        types = typeNames
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        abilities = abilityNames
        
        let spritesContainer = try container.nestedContainer(keyedBy: Keys.SpritesKey.self, forKey: .imageURL)
        imageString = try spritesContainer.decode(String.self, forKey: .front_default)
    }
    
}
