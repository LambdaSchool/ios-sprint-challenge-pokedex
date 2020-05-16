//
//  Pokemon.swift
//  PokedexSprint
//
//  Created by Clayton Watkins on 5/15/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable{
    //Keys for JSON Decoding
    enum PokemonKeys: String, CodingKey{
        case name, id, abilities, types, sprites
        
       enum AbilityDescriptionsKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys:String, CodingKey{
            case sprite = "front_default"
        }
        
        enum TypeDescriptionKey:String, CodingKey {
            case type
            
            enum TypeKeys:String, CodingKey{
                case name
            }
        }
    }
    
    //Properties we want to decode
    let name: String
    let id : Int
    let sprites: String
    let ability: [String]
    let types: [String]
    
    //Initalizer for our object when saving one
    init(name: String, id: Int, sprites: String, ability: [String], types: [String]){
        self.name = name
        self.id = id
        self.sprites = sprites
        self.ability = ability
        self.types = types
    }
    
    //Custom Decoder
    init(from decoder: Decoder) throws{
        
        //JSON Container
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        //Decoding easier, unnested properties
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        self.sprites = try spriteContainer.decode(String.self, forKey: .sprite)
        
        //Decoding nested property: Abilities
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilityNames: [String] = []
        while !abilitiesContainer.isAtEnd{
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionsKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionsKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        self.ability = abilityNames
        
        //Decoding nested property: Types
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typeNames: [String] = []
        while !typesContainer.isAtEnd{
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKey.self)
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKey.TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        self.types = typeNames
    }
}
