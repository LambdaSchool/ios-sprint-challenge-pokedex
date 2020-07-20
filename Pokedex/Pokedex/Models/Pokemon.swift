//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/19/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

struct Pokemon: Codable {

    let name: String
    let id: Int
    let image: URL
    let types: [String]
    let abilities: [String]

    enum PokemonKeys: String, CodingKey {
        case name, id, types, abilities
        case image = "sprites"

        enum imageKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        enum TypeDescriptionKeys: String, CodingKey {
            case type

            enum TypeKey: String, CodingKey {
                case name
            }
        }

        enum AbilitiesDescriptionKeys: String, CodingKey {
            case ability

            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)

        name = try container.decode(String.self, forKey: .name)

        let idString = try container.decode(Int.self, forKey: .id)
        id = idString

        let imageContainer = try container.nestedContainer(keyedBy: PokemonKeys.imageKeys.self, forKey: .image)
        image = try imageContainer.decode(URL.self, forKey: .frontDefault)


        var typeContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typeNames: [String] = []

        while typeContainer.isAtEnd == false {
            let typeDescriptionContainer = try typeContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.self)

            let typeContaienrs = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.TypeKey.self, forKey: .type)

            let typeName = try typeContaienrs.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        types = typeNames

        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)

        var abilityNames: [String] = []

        while abilitiesContainer.isAtEnd == false {
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilitiesDescriptionKeys.self)

            let abiityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.AbilitiesDescriptionKeys.AbilityKeys.self, forKey: .ability)

            let abilityName = try abiityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        abilities = abilityNames

    }
}
