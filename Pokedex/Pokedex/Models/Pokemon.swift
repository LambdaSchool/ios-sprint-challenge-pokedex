//
//  Pokemon.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
	let name: String
	let abilities: [Ability]
	let types: [Type]
	let id: Int
	let sprites: Sprite
}

struct Ability: Decodable {
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
