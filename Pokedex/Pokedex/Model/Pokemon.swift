//
//  Pokemon.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    var name: String
    var id: Int
    
//    struct abilities {
//        var ability: [String: String]
//    }
    
//    var types: String
//    var abilities: [[ String: String ]] //nested
//    var types: [[String :String]] //nested
    
    init(name: String, id: Int){
        self.name = name
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
  
        // nested containers
//        let abilitiesContainer = try container.nestedContainer(keyedBy: AbilitiesCodingKeys.self, forKey: .abilities)
//        abilities().ability = abilitiesContainer.decode([String: String].self, forKey: .ability)
        
        
        
//        let typesContainer = try container.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .types)
//        let type = try typesContainer.decode([String].self, forKey: .type)
//        self.types = type.first!
        
        
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
//        case abilities
//        case types
    }
    
//    enum AbilitiesCodingKeys: String, CodingKey {
//        case ability
//    }
//    
//    enum AbilityCodingKeys: String, CodingKey {
//        case name
//    }
    
//
//    enum TypeCodingKeys: String, CodingKey {
//        case type
//    }
    
}

