//
//  PokemonController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation


class PokemonController {
	
	var pokemon: [Pokemon] = []
	
	private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	
	func searchPokemon(for pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void ) {
		
	}
	
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case delete = "DELETE"
	case put = "PUT"
}

enum NetworkError: Error {
	case badResponse
	case otherError
	case badData
	case noDecode
}
