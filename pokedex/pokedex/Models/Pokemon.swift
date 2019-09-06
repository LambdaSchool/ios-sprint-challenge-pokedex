//
//  Pokemon.swift
//  pokedex
//
//  Created by Joshua Sharp on 9/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Pokemon:     Codable {
    let name:       String
    let id:         Int
    var abilities:  [AbilitySuper]
    let types:      [TypeSuper]
    let sprites:    Sprite
    var getAbilitiesString: String {
        var result: String = ""
        for ability in abilities {
            if result == "" {
                result += ability.ability.name
            } else {
                result += ", \(ability.ability.name)"
            }
        }
        return result
    }
    var getTypesString: String {
        var result: String = ""
        for type in types {
            if result == "" {
                result += type.type.name
            } else {
                result += ", \(type.type.name)"
            }
        }
        return result
    }
}

struct AbilitySuper: Codable {
    let ability:    Ability
}

struct Ability:     Codable {
    let name:       String
}

struct TypeSuper: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String
}
