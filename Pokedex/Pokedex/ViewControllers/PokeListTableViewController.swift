//
//  PokeListTableViewController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class PokeListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pokeController.pokemons.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		cell.textLabel?.text = pokeController.pokemons[indexPath.row].name
		return cell
	}
	
	let pokeController = PokeController()
}
