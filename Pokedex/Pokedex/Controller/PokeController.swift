//
//  PokeController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class PokeController {
	
	func fetchPokemonData(_ name: String) {
		var url = baseUrl.appendingPathComponent(name)
		
		print(url)
		
	}
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	private(set) var pokemons: [Pokemon] = []
}
