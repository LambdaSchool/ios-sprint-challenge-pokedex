//
//  Pokemon.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

struct PokemonResults: Decodable {

	let results: [Pokemon]

}

struct Pokemon: Decodable {
	var name: String
	var url: String
	var abilities: Abilities
	var id: Int
}

struct Abilities: Decodable {
	var name: String

}


