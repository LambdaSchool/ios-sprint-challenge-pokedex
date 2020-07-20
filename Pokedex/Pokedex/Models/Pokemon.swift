//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/19/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

class Pokemon: Codable {

    let name: String
    let id: Int
    let image: [URL]
    let types: [String]

    enum PokemonKeys: String, CodingKey {
        case name
        case id
        case types
        case image = "sprites"

        enum SpritesKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        enum TypeDescriptionKeys: String, CodingKey {
            case type

            enum TypeKey: String, CodingKey {
                case name
            }
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)

        name = try container.decode(String.self, forKey: .name)

        let idString = try container.decode(String.self, forKey: .id)
        id = Int(idString) ?? 0

        image = try container.decode([URL].self, forKey: .image)

        var typeContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var typeNames: [String] = []

        while typeContainer.isAtEnd == false {
            let typeDescriptionContainer = try typeContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.self)

            let typeContaienrs = try typeDescriptionContainer.nestedContainer(keyedBy: PokemonKeys.TypeDescriptionKeys.TypeKey.self, forKey: .type)

            let typeName = try typeContaienrs.decode(String.self, forKey: .name)
            typeNames.append(typeName)
        }
        types = typeNames


    }
}
