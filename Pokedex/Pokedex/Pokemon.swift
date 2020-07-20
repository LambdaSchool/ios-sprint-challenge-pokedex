//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let ability: [String]
    let types: [String]
    let sprites: String

    // Coding Keys
    enum PokemonKeys: String, CodingKey {
        case name, id, abilities, types, sprites

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
            case sprite = "front_default"
        }
    }

    init(from decoder: Decoder) throws {
        var abilityNames: [String] = []
        var typeNames: [String] = []

        // Containers
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)

        while !abilitiesContainer.isAtEnd {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionKeys.self)
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }

        while !typesContainer.isAtEnd {
            let typeDescriptionContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.self)
            let typeContainer = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }

        // Decoding data
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.sprites = try spriteContainer.decode(String.self, forKey: .sprite)
        self.ability = abilityNames
        self.types = typeNames
    }

    init(name: String, id: Int, ability: [String], types: [String], sprites: String) {
        self.name = name
        self.id = id
        self.ability = ability
        self.types = types
        self.sprites = sprites
    }

}
