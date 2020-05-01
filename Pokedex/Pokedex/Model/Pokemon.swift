//
//  Pokemon.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    var imageURL: String
    var abilities: [String]
    var types: [String]
    var weight: Int
    
    init(name: String, id: Int, imageURL: String, abilities: [String], types: [String], weight: Int){
        self.name = name
        self.id = id
        self.imageURL = imageURL
        self.abilities = abilities
        self.types = types
        self.weight = weight
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.weight = try container.decode(Int.self, forKey: .weight)
        
        let spriteContainer = try container.nestedContainer(keyedBy: SpriteCodingKeys.self, forKey: .imageURL)
        
        self.imageURL = try spriteContainer.decode(String.self, forKey: .image);
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilities = [String]()
        
        while !abilitiesContainer.isAtEnd {
            
            let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: AbilityCodingKeys.self).nestedContainer(keyedBy: AbilitySmallCodingKeys.self, forKey: .ability)
            
            let ability = try abilityContainer.decode(String.self, forKey: .name)
            
            abilities.append(ability)
            
        }
        
        self.abilities = abilities
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        var types = [String]()
        
        while !typesContainer.isAtEnd {
            
            let typeContainer = try typesContainer.nestedContainer(keyedBy: TypesCodingKeys.self).nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            
            types.append(type)
            
        }
        
        self.types = types
        
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case imageURL = "sprites"
        case abilities
        case types
        case weight
    }
    
    enum SpriteCodingKeys: String, CodingKey {
        case image = "front_default"
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case ability
    }
    
    enum AbilitySmallCodingKeys: String, CodingKey {
        case name
    }
    
    enum TypesCodingKeys: String, CodingKey {
        case type
    }
    
    enum TypeCodingKeys: String, CodingKey {
        case name
    }
    
    
    
    
    
    
}

