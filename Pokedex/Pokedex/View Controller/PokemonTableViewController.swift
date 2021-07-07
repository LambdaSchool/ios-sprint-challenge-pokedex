//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 5/17/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
	var pokemonController = PokemonController()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return pokemonController.pokemon.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		let currentPokemon = pokemonController.pokemon[indexPath.row]
		
		cell.textLabel?.text = currentPokemon.name
//		cell.imageView?.image = currentPokemon.sprites
		pokemonController.getImage(at: currentPokemon.sprites.frontDefault) { (result) in
			
			let image: UIImage?
			
			do {
				
				image = try result.get()
				DispatchQueue.main.async {
					cell.imageView?.image = image
				}
			} catch {
				
				NSLog("Error here")
			}
		}
		
		

		return cell
		
		
	}

	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			pokemonController.delete(indexOfPoke: indexPath)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SearchShow" {
			let searchVC = segue.destination as? SearchViewController
			searchVC?.pokemonController = pokemonController
		}
		else if segue.identifier == "DetailShow" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
			let detailVC = segue.destination as? SearchViewController
			detailVC?.pokemonController = pokemonController
			detailVC?.pokemon = pokemonController.pokemon[indexPath.row]
		}
	}
	}
	
}
