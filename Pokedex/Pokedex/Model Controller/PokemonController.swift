//
//  PokemonController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class PokemonController {

	var pokemon: [Pokemon] = []
	
	private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	
	func searchPokemon(for poke: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
		let searchURL = baseURL.appendingPathComponent(poke)
		
		var request = URLRequest(url: searchURL)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				(NSLog("Bad Response: \(response.statusCode)"))
				completion(.failure(.badResponse))
				return
			}
			
			if let error = error {
				NSLog("Error: \(error)")
				completion(.failure(.otherError))
				return
			}
			
			guard let data = data else {
				NSLog("Error: Bad Data)")
				completion(.failure(.badData))
				return
			}
			
			let decoder = JSONDecoder()
			do {
				let search = try decoder.decode(Pokemon.self, from: data)
				completion(.success(search))
			} catch {
				NSLog("Decoding error: \(error)")
				completion(.failure(.noDecode))
				return
			}
		}.resume()
	}
	
	func getImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
		let imageURL = URL(string: urlString)!
		
		var request = URLRequest(url: imageURL)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			if let _ = error {
				completion(.failure(.otherError))
				return
			}
			
			guard let data = data else {
				completion(.failure(.badData))
				return
			}
			
			let image = UIImage(data: data)!
			completion(.success(image))
		}.resume()
	}
	
	func save(poke: Pokemon) {
		pokemon.append(poke)
	}
	
	func delete(indexOfPokemon: IndexPath) {
		pokemon.remove(at: indexOfPokemon.row)
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
