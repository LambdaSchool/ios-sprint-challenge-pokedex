//
//  APIController.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

class APIController {

	var pokemons: [Pokemon] = []

	let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
	typealias CompletionHandler = (Error?) -> Void

	func getPokemons(completion: @escaping CompletionHandler = { _ in}) {
		URLSession.shared.dataTask(with: baseURL) { (data, response, error ) in

			if let error = error {
				NSLog("Error getting pokemons: \(error)")
			}

			guard let data = data else {
				NSLog("No data returned from dataTask.")
				completion(nil)
				return
			}

			do {
				let newPoke = try JSONDecoder().decode(PokemonResults.self, from: data)
				print(newPoke)
				self.pokemons = newPoke.results

			} catch {
				NSLog("Error decoding pokemons: \(error)")
				completion(error)
			}
			completion(nil)
		}.resume()
		}


}
