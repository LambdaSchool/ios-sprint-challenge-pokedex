//
//  Pokemon.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
	let id: Int
	let name: String
	let baseExperience: Int
	let height: Int
	let weight: Int
	let abilities: [PokemonAbilityInfo]
	let sprites: [String: String?]
	let types: [PokemonTypeInfo]

	struct PokemonAbilityInfo: Codable {
		struct PokemonAbility: Codable {
			let name: String
			let url: String
		}
		let ability: PokemonAbility
		let isHidden: Bool
		let slot: Int
	}

	struct PokemonTypeInfo: Codable {
		let slot: Int
		let type: PokemonType
		struct PokemonType: Codable {
			let name: String
			let url: String
		}
	}
}
