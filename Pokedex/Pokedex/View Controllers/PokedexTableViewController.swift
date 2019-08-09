//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
	
	var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemon.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		let currentPokemon = pokemonController.pokemon[indexPath.row]
		
		cell.textLabel?.text = currentPokemon.name
		pokemonController.getImage(at: currentPokemon.sprites.fontDefault) { (result) in
			
			let image: UIImage?
			
			do {
				image = try result.get()
				DispatchQueue.main.async {
					cell.imageView?.image = image
				}
			} catch {
				NSLog("Error here: \(error)")
			}
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			pokemonController.delete(indexOfPokemon: indexPath)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PokemonSearchShowSegue" {
			let searchVC = segue.destination as? PokemonDetailViewController
			searchVC?.pokemonController = pokemonController
		}
		else if segue.identifier == "PokemonDetailShowSegue" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let detailVC = segue.destination as? PokemonDetailViewController
				detailVC?.pokemonController = pokemonController
				detailVC?.pokemon = pokemonController.pokemon[indexPath.row]
			}
		}
	}
	
}
