//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

	@IBOutlet weak var textLabel: UILabel!
	

	var apiController = APIController()


    override func viewDidLoad() {
        super.viewDidLoad()

		apiController = APIController()
		//tableView.reloadData()


    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		tableView.reloadData()
	}



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return apiController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		let poke = apiController.pokemons[indexPath.row]
		cell.textLabel?.text = poke


        return cell
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SearchSegue" {
			guard let searchVC = segue.destination as? SearchViewController else { return }
			searchVC.apiController = apiController

		} else if segue.identifier == "ShowPokemonSegue" {

		}
	}

}
