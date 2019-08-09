//
//  MyPokemonTableVC.swift
//  Pokedex
//
//  Created by Jeffrey Santana on 8/9/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class MyPokemonTableVC: UITableViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var sortingSegControl: UISegmentedControl!
	
	//MARK: - Properties
	
	var pokeController: PokeController!
	var sortingType: SortBy {
		return sortingSegControl.selectedSegmentIndex == 0 ? .id : .name
	}
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pokeController = PokeController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		pokeController.sortPokemon(by: sortingType)
		tableView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let pokeSearchVC = segue.destination as? PokemonSearchVC {
			pokeSearchVC.pokeController = pokeController
			
			if segue.identifier == "ShowPokemonSegue", let indexPath = tableView.indexPathForSelectedRow {
				pokeSearchVC.pokemonToDisplay = pokeController.myPokemon[indexPath.row]
			}
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func sortByChanged(_ sender: UISegmentedControl) {
		pokeController.sortPokemon(by: sortingType)
		tableView.reloadData()
	}
	
	//MARK: - Helpers
	
	

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeController.myPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokeCell else { return UITableViewCell() }

        cell.pokemon = pokeController.myPokemon[indexPath.row]

        return cell
    }
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			self.pokeController.removePokemon(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			handler(true)
		}
		
		return UISwipeActionsConfiguration(actions: [delete])
	}
}
