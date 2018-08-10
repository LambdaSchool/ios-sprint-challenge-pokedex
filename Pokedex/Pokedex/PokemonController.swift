
import Foundation
import UIKit

class PokemonController
{
	var savedPokemon:[Pokemon] = []
	var	searchedPokemon:[Pokemon] = []
	var searchedPokemonBackup:[Pokemon] = []
	var lastSearchIndex = 0

	func save(_ poke:Pokemon)
	{
		if savedPokemon.index(of:poke) != nil {
			return
		}
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

		searchedPokemonBackup = searchedPokemon
		searchedPokemon = [Pokemon(name: "Loading...", id: -1, abilities: [], types: [])]

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
				self.searchedPokemon = self.searchedPokemonBackup
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
