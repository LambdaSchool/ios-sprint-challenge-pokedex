//
//  Pokemon.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import UIKit
import Foundation


struct Pokemon: Equatable, Decodable {
    var fetchedImage: UIImage? = nil
    let name: String
    let image: String
    let id: Int
    let ability: [String]
    let types: [String]
    
    init(name: String, image: String, id: Int, ability: [String], types: [String]) {
        self.name = name
        self.image = image
        self.id = id
        self.ability = ability
        self.types = types
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case types
        case sprites
        
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
        
        enum SpriteKeys: String, CodingKey {
            case image = "front_default"
        }
    }
    
    init(from decoder: Decoder) throws {
        
        var abilityNames: [String] = []
        var typeNames: [String] = []
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.SpriteKeys.self, forKey: .sprites)
        
        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        while typesContainer.isAtEnd == false {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.self)
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: CodingKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try spritesContainer.decode(String.self, forKey: .image)
        self.ability = abilityNames
        self.types = typeNames
        
    }
}
