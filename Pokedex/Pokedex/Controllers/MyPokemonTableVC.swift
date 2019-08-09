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
	
	
	//MARK: - Properties
	
	var pokeController: PokeController!
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pokeController = PokeController()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let pokeSearchVC = segue.destination as? PokemonSearchVC {
			pokeSearchVC.pokeController = pokeController
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeController.myPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = pokeController.myPokemon[indexPath.row]

        return cell
    }
}
