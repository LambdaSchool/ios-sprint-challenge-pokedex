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
    
    let name: String
    let id: Int
    let type: String
    let abilities: [String]
    
    //Coding Keys
    enum Keys: String, CodingKey {
        case id
        case name
        case type
        case abilities
                
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        id = try container.decode(Int.self, forKey: .id)
        
        type = try container.decode(String.self, forKey: .type)
        
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
