//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    enum CodingKeys: String, CodingKey {
        case name, id, types, abilities
        case image = "sprites"
        
        enum TypeCodingKeys: CodingKey {
            case name
        }
        
        enum AbilityCodingKeys: CodingKey {
            case name
        }
        
        enum ImageCodingKeys: CodingKey {
            case front_default
        }
        
    }
    
    var name: String
    var id: String
    var types: [Type]
    var abilities: [Ability]
    var image: URL
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        
        let typeContainer = try container.nestedContainer(keyedBy: CodingKeys.TypeCodingKeys.self, forKey: .name)
        self.types = try typeContainer // LEFT OFF HERE OUT OF TIME
        
        
        
    }
    
}

struct Type: Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    var name: String
}

struct Ability: Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    var name: String
}
