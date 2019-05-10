//
//  PokemonController.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class PokemonController {
	var pokemons: [Pokemon] = []


	//MARK:- Netstuff

	let baseURL = URL(string: "https://pokeapi.co/api/v2")!

	func getAllPokemon() {

	}

	func searchForPokemon(named: String, completion: @escaping (Error?)->Void) {
		
	}
}
