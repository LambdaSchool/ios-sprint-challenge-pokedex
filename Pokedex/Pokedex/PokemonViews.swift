//
//  PokemonViews.swift
//  Pokedex
//
//  Created by William Bundy on 8/10/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation
import UIKit

class SavedPokemonTVC:UITableViewController
{
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return App.controller.savedPokemon.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		cell.textLabel!.text = App.controller.savedPokemon[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? PokemonDetailVC {
			dest.poke = App.controller.savedPokemon[tableView.indexPathForSelectedRow?.row ?? 0]
		}
	}
}

class SearchPokemonTVC:UITableViewController, UISearchBarDelegate
{

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let query = searchBar.text, query != "" else {return}
		App.controller.query(query) { error in
			if error == nil {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return App.controller.searchedPokemon.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		cell.textLabel!.text = App.controller.searchedPokemon[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? PokemonDetailVC {
			dest.poke = App.controller.searchedPokemon[tableView.indexPathForSelectedRow?.row ?? 0]
		}
	}
}

class PokemonDetailVC:UIViewController
{
	var poke:Pokemon!

	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var abilityLabel: UILabel!
	override func viewWillAppear(_ animated: Bool) {

		nameLabel.text = poke.name
		idLabel.text = "ID: \(poke.id)"
		var types:[String] = []
		for type in poke.types {
			if let type = type.type {
				types.append(type.name)
			}
		}

		typeLabel.text = "Types: \(types.joined(separator: ", "))"

		var abilities:[String] = []
		for abil in poke.abilities  {
			if let ability = abil.ability {
				if abil.is_hidden ?? false {
					abilities.append("\(ability.name) (hidden)")
				} else {
					abilities.append(ability.name)
				}
			}
		}
		abilityLabel.text = "Abilities: \(abilities.joined(separator: ", "))"




	}
	@IBAction func savePokemon(_ sender: Any) {
		App.controller.save(poke!)
		navigationController?.popViewController(animated: true)
	}
}
