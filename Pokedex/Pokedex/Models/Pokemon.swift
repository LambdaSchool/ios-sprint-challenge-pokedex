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
	let abilities: [KeyString]
	let types: [KeyString]
}

struct KeyString: Codable {
	let name: String
}
