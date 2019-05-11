//
//  PokemonController.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PokemonController {
	private(set) var pokemons: [Pokemon] = []

	init() {
		loadPokemon()
	}


	func catchPokemon(_ pokemon: Pokemon) {
		pokemons.append(pokemon)
		savePokemon()
	}

	func releasePokemon(_ pokemon: Pokemon) {
		guard let index = pokemons.firstIndex(of: pokemon) else { return }
		pokemons.remove(at: index)
		savePokemon()
	}


	//MARK:- persistence

	var pokemonSaveURL: URL? {
		let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
		return documents?.appendingPathComponent("pokemon", isDirectory: false).appendingPathExtension("plist")
	}

	private func savePokemon() {
		let encoder = PropertyListEncoder()
		guard let pokemonSaveURL = pokemonSaveURL else { return }
		do {
			let saveData = try encoder.encode(pokemons)
			try saveData.write(to: pokemonSaveURL)
		} catch {
			print(error)
		}
	}

	private func loadPokemon() {
		let decoder = PropertyListDecoder()
		guard let pokemonSaveURL = pokemonSaveURL, FileManager.default.fileExists(atPath: pokemonSaveURL.path) else {
			print("path: \(self.pokemonSaveURL?.path)")
			return
		}

		do {
			let data = try Data(contentsOf: pokemonSaveURL)
			pokemons = try decoder.decode([Pokemon].self, from: data)
		} catch {
			print(error)
		}


	}


	//MARK:- Netstuff

	let baseURL = URL(string: "https://pokeapi.co/api/v2")!
	let networkHandler = NetworkHandler()

	func getAllPokemon() {
		fatalError()
	}

	func searchForPokemon(named: String, completion: @escaping (Result<Pokemon, NetworkError>)->Void) {
		var pokeSearchURL = baseURL.appendingPathComponent("pokemon")
		pokeSearchURL = pokeSearchURL.appendingPathComponent(named.lowercased())

		var request = URLRequest(url: pokeSearchURL)
		request.httpMethod = HTTPMethods.get.rawValue

		networkHandler.transferMahCodableDatas(with: request) { (result: Result<Pokemon, NetworkError>) in
			do {
				let pokemon = try result.get()
				completion(.success(pokemon))
			} catch {
				completion(.failure((error as? NetworkError) ?? NetworkError.otherError(error: error)))
			}
		}
	}

	func getSprite(withURL url: URL, requestID: String, completion: @escaping (Result<(id: String, image: UIImage), Error>) -> Void) {
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethods.get.rawValue

		networkHandler.fetchMahDatas(with: request, requestID: requestID) { (requestID, data, error) in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				completion(.failure(NetworkError.badData))
				return
			}

			guard let requestID = requestID else {
				completion(.failure(NetworkError.noResponse)) // technically this is wrong, but its not the pattern im going forward with anyways so...
				return
			}

			guard let image = UIImage(data: data) else {
				completion(.failure(NetworkError.noDecodeImage))
				return
			}
			completion(.success((requestID, image)))
		}
	}
}
