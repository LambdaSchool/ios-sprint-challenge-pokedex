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
	

	init(name: String, id: Int, types: [Type]) {
		self.name = name
		self.id = id
		self.types = types
	}
	
	// let abilities: [abilities]
	
	let types: [Type]
	let name: String
	let id: Int
}


class Type: Codable, Equatable{
	static func == (lhs: Type, rhs: Type) -> Bool {
		return lhs.slot == rhs.slot
	}
	
	let slot: Int
	let type: [TypeNames]
	
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let typesDictionaries = try container.decodeIfPresent([String: TypeNames].self, forKey: .type)
		let typeNames = typesDictionaries?.compactMap({ $0.value }) ?? []

		let slot = try container.decode(Int.self, forKey: .slot)
		
		self.slot = slot
		self.type = typeNames
	
	}
	
	
	
}

struct TypeNames: Codable, Equatable {
	var name: String
}
