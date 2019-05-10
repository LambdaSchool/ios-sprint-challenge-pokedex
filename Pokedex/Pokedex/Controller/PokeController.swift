//
//  PokeController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case noAuth
	case badAuth
	case otherError
	case badData
	case noDecode
}

class PokeController {
	
	func catchPokemon(poke: Pokemon) {
		pokemons.append(poke)
	}
	
	func fetchPokemonData(_ name: String, completion: @escaping (Error?) -> ()){
		let url = baseUrl.appendingPathComponent(name)

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		print(url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let response = response as? HTTPURLResponse {
				print("Fetch Data Response: ", response.statusCode)
				if response.statusCode == 404 {
					print("error: Wrong id or name")
				}
			}
			
			if let error = error {
				print("error: \(error)")
				completion(error)
				return
			}
			
			guard let data = data else {
				print("error fetching Data")
				completion(nil)
				return
			}
			
			let decoder = JSONDecoder()
			let poke: Pokemon
			do {
				poke = try decoder.decode(Pokemon.self, from: data)
				print(poke.name, poke.id)
				self.currentPokemon = poke
			} catch {
				print("error decoding pokemon")
				completion(error)
				return
			}
			completion(nil)
		}.resume()
		
	}
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	private(set) var pokemons: [Pokemon] = []
	private(set) var currentPokemon: Pokemon? = nil
}
