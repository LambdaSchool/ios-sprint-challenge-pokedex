//
//  PokeController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class PokeController {
	
	func fetchPokemonData() {
		var url = baseUrl.appendingPathComponent("pokemon")
		
		print(url)
		
	}
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
	private(set) var pokemons: [Pokemon] = []
}
