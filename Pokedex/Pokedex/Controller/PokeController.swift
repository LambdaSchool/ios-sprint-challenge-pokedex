//
//  PokeController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

enum NetworkError: Error {
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
			let pokemon: Pokemon
			do {
				pokemon = try decoder.decode(Pokemon.self, from: data)
				print(pokemon.name, pokemon.id)
				self.currentPokemon = pokemon
			} catch {
				print("error decoding pokemon")
				completion(error)
				return
			}
			completion(nil)
		}.resume()
	}
	
	func fetchImage(with url: String, completion: @escaping (Error?) -> ()) {
		let imageurl = URL(string: url)!
		var request = URLRequest(url: imageurl)
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let error = error {
				completion(error)
				return
			}
			guard let data = data else { return }
			print(data)
			let image = UIImage(data: data)
			self.currentImage = image
			completion(nil)
		}.resume()
	}
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	private(set) var pokemons: [Pokemon] = []
	private(set) var currentPokemon: Pokemon? = nil
	
	private(set) var currentImage: UIImage? = nil
}
