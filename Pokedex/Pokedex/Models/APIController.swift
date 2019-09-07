//
//  APIController.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

class APIController {

	private(set) var pokemons = [String]()

	private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
	typealias CompletionHandler = (Error?) -> Void

	func addPokemon(pokemon: String) {
		if !pokemons.contains(pokemon) {
			pokemons.append(pokemon)
		}
	}

	func getPokemons(by searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

		let pokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm.lowercased())")
		let request = URLRequest(url: pokemonURL)

		URLSession.shared.dataTask(with: request) { (data, response, error ) in

			if let error = error {
				NSLog(error.localizedDescription)
				//NSLog("Error getting pokemons: \(error)")
				completion(.failure(.otherError))
				return
			}

			guard let data = data else {
				NSLog("No data returned from dataTask.")
				completion(.failure(.noData))
				return
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let newPoke = try decoder.decode(Pokemon.self, from: data)
				print(newPoke)
				completion(.success(newPoke))

			} catch {
				NSLog("Can't decode")
				completion(.failure(.noDecode))
			}
		}.resume()
		}


}
