//
//  Pokemon.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class Pokemon: Codable  {

    let name: String
    let id: Int

    let abilities: [Ability]
    let types: [Types]

    let sprites: [Sprite]

    init(name: String, id: Int, abilities: [Ability], types: [Types], sprites: [Sprite] ) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }


    required init(from decoder: Decoder) throws {


        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        let sprites = try container.decode([Sprite].self, forKey: .sprites)
        let abilitiesDictionaries = try container.decodeIfPresent([String: Ability].self, forKey: .abilities)
        let typesDictionaries = try container.decodeIfPresent([String: Types].self, forKey: .types)

        let abilities = abilitiesDictionaries?.compactMap({ $0.value }) ?? []
        let types = typesDictionaries?.compactMap({ $0.value }) ?? []
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprites = sprites


    }
}
struct Name: Codable {
    let name: String
}
struct Ability: Codable {
    let Ability: Name
}
struct Types: Codable {
    let type: Name
}
struct Sprite: Codable {
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    
    let frontDefault: String
}

