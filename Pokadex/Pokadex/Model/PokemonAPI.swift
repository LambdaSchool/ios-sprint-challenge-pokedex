//
//  PokemonAPI.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case encodingError
	case responseError
	case otherError
	case noData
	case noDecode
}

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

class PokemonAPIController {
	
	//MARK: - properties
	var pokemons: [Pokemon] = []
	var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
	typealias completionHandler = (NetworkError) -> Void
	
	//MARK: - methods
	func getPokemon(with name:String, completion: @escaping completionHandler) {
		let pokemonURL = baseURL
			pokemonURL.appendingPathComponent(name)
		
		var request = URLRequest(url: pokemonURL)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: baseURL){ ( data, response, error) in
			if let error = error {
				NSLog("error getting Pokemon: \(error)")
				completion(.otherError)
				return
			}
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				completion(.responseError)
				return
			}
			guard let data = data else {
				completion(.noData)
				return
			}
			let decoder = JSONDecoder()
			
			do {
				let pokemon = try decoder.decode(PokemonResults.self, from: data)
				self.pokemons = pokemon.results
			} catch {
				NSLog("error decoding pokemon: \(error)")
				completion(.noDecode)
				return
			}
		}.resume()
	}
	
	
}
