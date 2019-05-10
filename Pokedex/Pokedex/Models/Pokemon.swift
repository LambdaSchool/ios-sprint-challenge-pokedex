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
	
//	required init(from decoder: Decoder) throws {
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		let typesDictionaries = try container.decodeIfPresent([String: Type].self, forKey: .types)
//		let types = typesDictionaries?.compactMap({ $0.value }) ?? []
//		
//		let name = try container.decode(String.self, forKey: .name)
//		let id = try container.decode(Int.self, forKey: .id)
//		
//		self.name = name
//		self.id = id
//		self.types = types
//	}
//	
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


class Type: Codable{
	let slot: Int
	//var typeName: [TypeNames]
	
	
}

struct TypeNames: Codable {
	var name: String
}
