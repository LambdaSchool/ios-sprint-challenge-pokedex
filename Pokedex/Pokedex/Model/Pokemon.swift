//
//  Pokemon.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
	
	let name: String
	let id: Int
	let abilities: [Ability]
	let types: [Type]
	let sprites: Sprites
	
}

struct Ability: Codable {
	let ability: Name
}

struct Sprites: Codable {
	let frontDefault: String
	
	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
	}
}

struct Type: Codable {
	let type: Name
}


struct Name: Codable {
	let name: String
}
