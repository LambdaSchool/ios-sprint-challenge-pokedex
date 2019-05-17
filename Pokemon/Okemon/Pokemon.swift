//
//  Pokemon.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {

    let name: String
    let id: Int

    let abilities: [Pokemon.Ability]
    let types: [Pokemon.Types]

    let sprites: Sprite

    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    init(name: String, id: Int, abilities: [Pokemon.Ability], types: [Pokemon.Types], sprites: Sprite) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }

    struct Ability:Equatable, Codable {
        let ability: String
    }
    struct Types:Equatable, Codable {
        let type: String
    }
    struct Sprite:Equatable, Codable {

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }


        let frontDefault: String
    }


    required init(from decoder: Decoder) throws {


        let container = try decoder.container(keyedBy: CodingKeys.self)


        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        let abilityDictionary = try container.decodeIfPresent([String: Ability].self, forKey: .abilities)
        let typesDictionary = try container.decodeIfPresent([String: Types].self, forKey: .types)
        let sprites = try container.decode(Sprite.self, forKey: .sprites)



        let abilities = abilityDictionary?.compactMap({ $0.value }) ?? []
        let types = typesDictionary?.compactMap({ $0.value }) ?? []

        // 4
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites

    }

}
