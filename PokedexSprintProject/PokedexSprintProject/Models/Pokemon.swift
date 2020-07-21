//
//  Pokemon.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {

    //Coding Keys
    enum Keys: String, CodingKey {
        case id
        case name
        case types
        case abilities
        case image
        
        enum TypesDescriptionKeys: String, CodingKey {
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
    }
    
  
    
    let name: String
    let id: Int
    let types: [String]
    let abilities: [String]


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        id = try container.decode(Int.self, forKey: .id)
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        var typeNames: [String] = []
        
        while typesContainer.isAtEnd == false {
            let typesDescriptionContainer = try typesContainer.nestedContainer(keyedBy: Keys.TypesDescriptionKeys.self)
            
            let typeContainer = try typesDescriptionContainer.nestedContainer(keyedBy: Keys.TypesDescriptionKeys.TypeKeys.self, forKey: .type)
            
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        
        types = typeNames
        

        
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            // abilitiesContainer points to the "n"th item in the array
            
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        abilities = abilityNames
    }
    
   
}
