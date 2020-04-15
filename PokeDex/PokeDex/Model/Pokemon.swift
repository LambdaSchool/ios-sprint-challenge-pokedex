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
    var sprites: URL?
    
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
        case abilityIndex
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case name
    }
    
    enum TypesCodingKeys: String, CodingKey {
        case typeIndex
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
        self.id = try container.decode(Int.self, forKey: .id)
        
        // Name
        let nameContainer = try container.nestedContainer(keyedBy: SpeciesCodingKeys.self, forKey: .species)
        self.name = try nameContainer.decode(String.self, forKey: .name)
        
        // Abilities
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while !abilitiesContainer.isAtEnd {
            let abilityIndexContainer = try abilitiesContainer.nestedContainer(keyedBy: AbilitiesCodingKeys.self)
            let abilityContainer = try abilityIndexContainer.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .abilityIndex)
            let ability = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(ability)
        }
        
        // Types
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        var typeNames: [String] = []
        
        while !typesContainer.isAtEnd {
            let typeIndexContainer = try typesContainer.nestedContainer(keyedBy: TypesCodingKeys.self)
            let typeContainer = try typeIndexContainer.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .typeIndex)
            let type = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(type)
        }
        
        // Sprites
        let spriteContainer = try container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        
        if let spriteString = try spriteContainer.decodeIfPresent(String.self, forKey: .frontDefault) {
            self.sprites = URL(string: spriteString)
        }
    }
}


struct PokemonSearchResults: Decodable {
    var result: Pokemon
    
}
