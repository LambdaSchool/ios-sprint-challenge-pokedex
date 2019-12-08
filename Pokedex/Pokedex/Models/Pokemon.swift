//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprite
    let abilities: [Ability]
    let types: [Type]
}

//Sprite
struct Sprite: Codable {
    let frontDefault: URL
}

//Ability
struct Ability: Codable {
    let ability: AbilityDet
}

struct AbilityDet: Codable {
    let name: String
}

//Type
struct Type: Codable {
    let type: TypeDet
}

struct TypeDet: Codable{
    let name: String
}
