//
//  Pokemon.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case sprites
        case types
        
        enum AbilityDescriptionsKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        enum SpritesKeys: String, CodingKeys {
            case sprite = "front_default"
        }
    }
    
    let id: Int
    let name: String
    let abilites: [String]
    let sprites: URL
    let type: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        var abilitiesContainer = try container.nestedUnkeyedContainer (forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionsKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionsKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        self.abilites = abilityNames
        
        self.sprites = try container.decode
    }
    
}

let url = URL
