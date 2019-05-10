//
//  PokeController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class PokeController {
	
	func fetchPokemonData(_ name: String, completion: @escaping (Error?) -> Void) {
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
				completion(NSError(domain: "", code: 0, userInfo: nil))
				return
			}
			
			let decoder = JSONDecoder()
			do {
				let pokemon = try decoder.decode(Pokemon.self, from: data)
				print(pokemon.name, pokemon.id)
				self.pokemons.append(pokemon)
			} catch {
				print("error decoding pokemon")
				completion(error)
				return
			}
			
			
			print(data)
			completion(nil)
		}.resume()
		
	}
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	private(set) var pokemons: [Pokemon] = []
}
