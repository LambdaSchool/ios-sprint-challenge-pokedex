//
//  Pokemon.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//
//swiftlint:disable identifier_name nesting

import Foundation

struct Pokemon: Equatable, Codable {
	let id: Int
	let name: String
	let baseExperience: Int
	let height: Int
	let weight: Int
	let abilities: [PokemonAbilityInfo]
	let sprites: [String: String?]
	let types: [PokemonTypeInfo]

	let uuid = UUID().uuidString

	struct PokemonAbilityInfo: Equatable, Codable {
		struct PokemonAbility: Equatable, Codable {
			let name: String
			let url: String
		}
		let ability: PokemonAbility
		let isHidden: Bool
		let slot: Int
	}

	struct PokemonTypeInfo: Equatable, Codable {
		let slot: Int
		let type: PokemonType
		struct PokemonType: Equatable, Codable {
			let name: String
			let url: String
		}
	}

	static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
		return lhs.uuid == rhs.uuid
	}
}
