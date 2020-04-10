//
//  Pokemon.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    enum PokemonCodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case types
        case sprites
        
        enum SpriteCodingKeys: String, CodingKey {
                   case frontDefault = "front_default"
               }
    }
    
    
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    var sprites: Sprites
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let newAbilities = try container.decodeIfPresent([Abilities].self, forKey: .abilities)
       self.abilities = newAbilities ?? []
        let newTypes = try container.decodeIfPresent([Types].self, forKey: .types)
        self.types = newTypes ?? []
        
            var spriteContainer = try container.nestedContainer(keyedBy: PokemonCodingKeys.SpriteCodingKeys.self, forKey: .sprites)
            self.sprites =  try spriteContainer.decode(Sprites.self, forKey: .frontDefault)
  
        
    }
    
    struct Ability: Codable {
        var name: String
    }
    
    //Abilities
    
    struct Abilities: Codable {
        
        enum AbilityCodingKeys: String, CodingKey {
            case ability
            
            enum NameCodingKeys: String, CodingKey {
                case name
            }
        }
        var ability: Ability
        
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: AbilityCodingKeys.self)
            self.ability = try container.decode(Ability.self, forKey: .ability)
            let abilityContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.NameCodingKeys.self, forKey:  .ability)
            self.ability = try abilityContainer.decode(Ability.self, forKey: .name)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: AbilityCodingKeys.self)
            
            var abilityContainer = container.nestedContainer(keyedBy: AbilityCodingKeys.NameCodingKeys.self, forKey: .ability)
            try abilityContainer.encode(ability, forKey: .name)
            
        }
    }
    struct Sprites: Codable {
         let frontDefault: String?
        
       
    }
    
    // Types
    struct Types: Codable {
        
        enum TypeCodingKeys: String, CodingKey {
            case type
            
            enum TypeNameCodingKeys: String, CodingKey {
                case name
            }
        }
        
        var type: Type
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TypeCodingKeys.self)
            self.type = try container.decode(Type.self, forKey: .type)

            let typeContainer = try container.nestedContainer(keyedBy: TypeCodingKeys.TypeNameCodingKeys.self, forKey: .type )
            self.type = try typeContainer.decode(Type.self, forKey: .name)

        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: TypeCodingKeys.self)

            var typeContainer = container.nestedContainer(keyedBy: TypeCodingKeys.TypeNameCodingKeys.self, forKey: .type)
            try typeContainer.encode(type, forKey: .name)

        }
    }
   
  
}


struct Type: Codable {
    var name: String
}


