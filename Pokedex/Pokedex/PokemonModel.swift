//
//  PokemonModel.swift
//  Pokedex
//
//  Created by William Bundy on 8/10/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation

typealias CompletionHandler = (String?) -> Void
enum App
{
	static let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon/")!
	static var controller = PokemonController()
}

func buildRequest(_ ids:[String], _ httpMethod:String, _ data:Data?=nil) -> URLRequest
{
	var url = App.baseURL
	for id in ids {
		url.appendPathComponent(id)
	}
	var req = URLRequest(url: url)
	req.httpMethod = httpMethod
	req.httpBody = data
	return req
}

struct Pokemon: Codable, Comparable
{
	// this is basically the json tree
	// it's hacky, but I don't care to learn the JSON
	// navigation stuff just yet
	struct PokeField: Codable
	{
		struct PokeFieldInner: Codable
		{
			var name:String
		}

		var is_hidden:Bool?
		var ability: PokeFieldInner?
		var type:PokeFieldInner?
	}


	var name:String
	var id:Int
	var abilities:[PokeField]
	var types:[PokeField]

	static func ==(l:Pokemon, r:Pokemon) -> Bool
	{
		return l.id == r.id
	}
	static func <(l:Pokemon, r:Pokemon) -> Bool
	{
		return l.id < r.id
	}

}

class PokemonController
{
	var savedPokemon:[Pokemon] = []
	var	searchedPokemon:[Pokemon] = []
	var lastSearchIndex = 0

	func save(_ poke:Pokemon)
	{
		savedPokemon.append(poke)
		savedPokemon.sort()
	}

	func delete(_ poke:Pokemon)
	{
		guard let index = savedPokemon.index(of:poke) else {return}
		savedPokemon.remove(at: index)
	}

	func query(_ name:String, _ completion:@escaping CompletionHandler)
	{
		for poke in searchedPokemon {
			if poke.name == name {
				completion("Pokemon already in search list!")
				return
			}
		}

		let req = buildRequest([name.lowercased()], "GET")
		URLSession.shared.dataTask(with: req)  {(data, _, error) in
			if let error = error {
				NSLog("Error fetching: \(error)")
				completion("The API returned an error when fetching")
				return
			}

			guard let data = data else {
				NSLog("Error fetching: data was nil!")
				completion("Error fetching: data was nil!")
				return
			}

			do {
				let dec = JSONDecoder()
				let poke = try dec.decode(Pokemon.self, from: data)

				// Insert at top of list
				self.searchedPokemon.insert(poke, at: 0)
				completion(nil)
			} catch {
				NSLog("Error fetching: could not decode data")
				NSLog(String(data:data, encoding:.utf8) ?? "Data was not UTF8")
				completion("Error fetching: could not decode data")
				return
			}
		}.resume()
	}
}



