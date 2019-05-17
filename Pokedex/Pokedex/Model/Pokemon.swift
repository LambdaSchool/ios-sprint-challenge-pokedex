//
//  Pokemon.swift
//  Pokedex
//
//  Created by Taylor Lyles on 5/17/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
	let id: Int
	let name: String
	let abilities: [Ability]
	let sprites: Sprites
	let types: [Type]
}

struct Ability: Codable {
	let ability: Class
	
}


struct Sprites: Codable {
	let frontDefault: String
	
	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
	}
	
}

struct Class: Codable {
	let name: String
}

struct Type: Codable {
	let type: Class
}
