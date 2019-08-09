//
//  Pokemon.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation
import SpriteKit

struct Pokemon: Codable {
	
	let name: String
	let Id: Int
	let abilities: [Abilities]
	let type: [Type]
	let sprites: Sprites
	
}

struct Sprites: Codable {
	let fontDefault: String
	
	enum CodingKeys: String, CodingKey {
		case fontDefault = "font_default"
	}
}

struct Type: Codable {
	let type: String
}

struct Abilities: Codable {
	let abilities: String
}
