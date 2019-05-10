//
//  Pokemon.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {
	static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
		return lhs.id == rhs.id
	}
	

	init(name: String, id: Int, types: [Type], abilities: [Abilities]) {
		self.name = name
		self.id = id
		self.types = types
		self.abilities = abilities
	}
	
	
	let abilities: [Abilities]
	let types: [Type]
	let name: String
	let id: Int
}


struct Type: Codable, Equatable{
	static func == (lhs: Type, rhs: Type) -> Bool {
		return lhs.slot == rhs.slot
	}
	
	let slot: Int
	let type: TypeNames
	
	
	struct TypeNames: Codable, Equatable {
		var name: String
	}
}

struct Abilities: Codable, Equatable {
	let ability: Ability
	
	struct Ability: Codable, Equatable {
		let name: String
	}
}
