//
//  Pokemon.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

struct PokemonResults: Decodable {
	var results:[Pokemon]
}

struct Pokemon: Decodable {

	let name: String
	let abilities: PokemonAbilities
}

struct PokemonAbilities: Decodable {
	let ability: PokemonAbility
	let id: Int
}

struct PokemonAbility: Decodable {
	let name: String
}
