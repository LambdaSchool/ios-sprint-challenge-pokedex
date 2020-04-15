//
//  Pokemon.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String?
    var id: Int?
    var abilities: String?
    var types: String?
    var sprites: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case abilities
        case types
        case species
        case sprites
    }
    
    enum SpeciesCodingKeys: String, CodingKey {
        case name
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
    
    enum SpritesCodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // ID
        id = try container.decode(Int.self, forKey: .id)
        
        // Name
        let nameContainer = try container.nestedContainer(keyedBy: SpeciesCodingKeys.self, forKey: .species)
        self.name = try nameContainer.decode(String.self, forKey: .name)
        
        // Abilities
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: AbilityCodingKeys.self)
//        self.abilities = try abilityContainer.decode(String.self, forKey: .name)
        
        var abilityNames: [String] = []
        
        while !abilitiesContainer.isAtEnd {
            let ability = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(ability)
        }
        
        // Types
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        let typeContainer = try typesContainer.nestedContainer(keyedBy: TypeCodingKeys.self)
//        self.types = try typeContainer.decode(String.self, forKey: .name)
        
        var typeNames: [String] = []
        
        while !typesContainer.isAtEnd {
            let type = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(type)
        }
        
        // Sprites
        let spriteContainer = try container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        self.sprites = try spriteContainer.decode(String.self, forKey: .frontDefault)
        


    }
    
}

//struct PokemonSprites: Decodable {
//       var frontDefault: String
//
//       enum CodingKeys: String, CodingKey {
//           case frontDefault = "front_default"
//       }
//   }
//
//   struct Abilities: Decodable {
//       var ability: NamedAPIResource
//
//       enum CodingKeys: String, CodingKey {
//           case ability
//       }
//       struct NamedAPIResource: Decodable {
//           var name: String
//       }
//   }
//
//   struct PokemonType: Decodable {
//       var type: NamedAPIResource
//
//       enum CodingKeys: String, CodingKey {
//           case type
//       }
//       struct NamedAPIResource: Decodable {
//           var name: String
//       }
//   }


struct PokemonSearchResults: Decodable {
    var result: Pokemon
    
}
