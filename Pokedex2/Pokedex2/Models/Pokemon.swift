//
//  Pokemon.swift
//  Pokedex2
//
//  Created by Clean Mac on 7/19/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    let id: Int
    let name: String
    let sprite: URL
    let abilities: [String]

    enum Keys: String, CodingKey {
        case name
        case abilities
        case sprites
        case id
        
        enum SpriteKeys: String, CodingKey {
            case front_default
        }
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
        
        let spritesContainer = try container.nestedContainer(keyedBy: Keys.SpriteKeys.self, forKey: .sprites)
        sprite = try spritesContainer.decode(URL.self, forKey: .front_default)
        
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        abilities = abilityNames
    }
}
