//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jeffrey Santana on 8/9/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
	let id: Int
	let name: String
	let abilities: [Ability]
	let types: [Type]
	let sprites: Sprite
}

struct Ability: Codable {
	let ability: KeyString
}

struct Type: Codable {
	let type: KeyString
}

struct Sprite: Codable {
	let frontDefault: URL
	let backDefault: URL
}

struct KeyString: Codable {
	let name: String
	let url: URL
}
