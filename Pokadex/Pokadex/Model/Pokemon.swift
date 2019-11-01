//
//  Pokemon.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
	let name: String
	let id:Int
	let sprites: Sprite
	let abilities: [Ability]
    let types: [Type]
}

struct Abilities: Decodable {
    let abilities: Ability
}

struct Ability: Decodable {
    let ability: abilityName
}
struct Type: Decodable {
    let type: TypeName
}
struct TypeName: Decodable {
    let name: String 
}
struct abilityName: Decodable {
    let name:String
}

struct Sprite: Decodable {
	let frontDefault: URL
}
