//
//  PokemonTableViewController.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
	
	//MARK: - properties
	var pokemonController = PokemonAPIController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		let pokemon = pokemonController.pokemons[indexPath.row]
		cell.textLabel?.text = pokemon.name
        return cell
    }
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddPokemon" {
			guard let addPokemonVC = segue.destination as? AddPokemonViewController
				else {return}
			addPokemonVC.delegate = self
		} else if segue.identifier == "PokemonDetail" {
			guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
			let indexpath = tableView.indexPathForSelectedRow else {return}
			pokemonDetailVC.pokemon = pokemonController.pokemons[indexpath.row]
			
		}
    }
}
extension PokemonTableViewController: AddPokemonDelegate {
	func addPokemon() {
		
	}
	
	
}
