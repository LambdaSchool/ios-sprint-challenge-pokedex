//
//  PokemonListTableViewController.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PokemonListTableViewController: UITableViewController {

	let pokemonController = PokemonController()


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? PokemonSearchViewController {
			dest.pokemonController = pokemonController
			if segue.identifier == "SearchForPokemon" {
			} else if segue.identifier == "ShowExistingPokemon" {
				guard let indexPath = tableView.indexPathForSelectedRow else { return }
				dest.alreadyCaught = true
				dest.pokemon = pokemonController.pokemons[indexPath.row]
			}

		}
	}
}

//MARK:- table view delegate and data stuff
extension PokemonListTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pokemonController.pokemons.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonNameCell", for: indexPath)
		cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name.capitalized

		return cell
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let pokemon = pokemonController.pokemons[indexPath.row]
			pokemonController.releasePokemon(pokemon)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
}
