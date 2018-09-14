//
//  Pokemon.swift
//  Pokedex
//
//  Created by Daniela Parra on 9/14/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    let name: String
    let id: Int
    let types: String  //[Types]
    let abilities: String //[Abilities]
    
//    init(name: String, id: Int, abilities: String) {
//        
//        self.name = name
//        self.id = id
//        self.abilities = abilities
//    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)

        let abilitiesContainer = try container.nestedContainer(keyedBy: AbilitiesCodingKeys.self, forKey: .abilities)
        let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
        let abilityName = try abilityContainer.decode(String.self, forKey: .name)
        
        self.abilities = abilityName
        
        let typesContainer = try container.nestedContainer(keyedBy: TypesCodingKeys.self, forKey: .types)
        let typeContainer = try typesContainer.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
        let typeName = try typeContainer.decode(String.self, forKey: .name)
        
        self.types = typeName
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case types
        case abilities
    }

    enum AbilitiesCodingKeys: String, CodingKey {
        case ability
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case name
    }
    
    enum TypesCodingKeys: String, CodingKey {
        case type
    }
    
    enum TypeCodingKeys: String, CodingKey {
        case name
    }
    
//
//
//    struct Abilities: Equatable, Codable {
//        let ability: MoreDetail
//
//        struct MoreDetail: Equatable, Codable {
//            let name: String
//        }
//    }
//
//    struct Types: Equatable, Codable {
//        let type: Name
//
//        struct Name: Equatable, Codable {
//            let name: String
//        }
//    }
    
}
