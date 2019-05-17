//
//  PokemonController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 5/17/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum NetworkError: Error {
	case badResponse
	case otherError
	case badData
	case noDecode
}

class PokemonController {
	var pokemon: [Pokemon] = []
	private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	
	func search(for poke: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
		let url = baseURL.appendingPathComponent(poke)
		
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				print("Bad Response: \(response.statusCode)")
				completion(.failure(.badResponse))
				return
			}
			
			if let error = error {
				NSLog("Error: \(error)")
				completion(.failure(.otherError))
				return
			}
			
			guard let data = data else {
				NSLog("Data error")
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
		
		func getImage(urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
			let url = URL(string: urlString)!
			
			var request = URLRequest(url: url)
			request.httpMethod = HTTPMethod.get.rawValue
			
			URLSession.shared.dataTask(with: request) { (data, blank, error) in
				if let blank = error {
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
		
		func delete(indexOfPoke: IndexPath) {
			pokemon.remove(at: indexOfPoke.row)
		}
		
	}
}
