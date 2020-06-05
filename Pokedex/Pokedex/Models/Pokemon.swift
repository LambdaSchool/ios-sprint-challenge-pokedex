//
//  Pokemon.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

struct Pokemon: Codable, Equatable {
    
    let name: String
    let types: [TypeInfo]
    let abilities: [AbilityInfo]
    let id: Int
    let sprites: SpriteFront
    
    struct AbilityInfo: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    struct TypeInfo: Codable, Equatable {
        let type: PokeType
        
        struct PokeType : Codable, Equatable {
            let name: String
        }
    }
    
    struct SpriteFront: Codable, Equatable {
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
        }
    }
}



/*
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
 enum SpritesKeys: String, CodingKey {
 case sprite = "front_default"
 }
 enum TypesDescriptionKeys: String, CodingKey {
 case type
 
 enum TypeKeys: String, CodingKey {
 case name
 }
 }
 }
 
 let id: Int
 let name: String
 let abilites: [String]
 let sprites: URL
 let types: [String]
 
 init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 
 
 //ID
 self.id = try container.decode(Int.self, forKey: .id)
 
 //NAME
 self.name = try container.decode(String.self, forKey: .name)
 
 //ABILITIES
 var abilitiesContainer = try container.nestedUnkeyedContainer (forKey: .abilities)
 
 var abilityNames: [String] = []
 
 while abilitiesContainer.isAtEnd == false {
 let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionsKeys.self)
 let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: CodingKeys.AbilityDescriptionsKeys.AbilityKeys.self, forKey: .ability)
 let abilityName = try abilityContainer.decode(String.self, forKey: .name)
 abilityNames.append(abilityName)
 }
 self.abilites = abilityNames
 
 //SPRITE
 let spriteContainer = try container.nestedContainer(keyedBy: CodingKeys.SpritesKeys.self, forKey: .sprites)
 self.sprites = try spriteContainer.decode(URL.self, forKey: .sprite)
 
 //TYPE
 var typesContainer = try container.nestedUnkeyedContainer (forKey: .types)
 
 var typesNames: [String] = []
 
 while typesContainer.isAtEnd == false {
 let typesDescriptionContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypesDescriptionKeys.self)
 let typesContainer = try typesDescriptionContainer.nestedContainer(keyedBy: CodingKeys.TypesDescriptionKeys.TypeKeys.self, forKey: .type)
 let typesName = try typesContainer.decode(String.self, forKey: .name)
 typesNames.append(typesName)
 }
 self.types = typesNames
 
 }
 
 
 }
 
 
 */
