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
    let type: String
    let images: [URL]

    enum PokemonKeys: String, CodingKey {
        case name, id, types
        case image = "sprites"
    }

    enum SpritesKeys: String, CodingKey {
        case frontDefult = "front_default"
    }

    enum TypeDescriptionKeys: String, CodingKey {
        case type

        enum TypeKey: String, CodingKey {
            case name
        }
    }


}
