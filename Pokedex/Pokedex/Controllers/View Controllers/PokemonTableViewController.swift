//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 17/01/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = apiController.pokemon[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailShowSegue" {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
                pokemonDetailVC.apiController = apiController
                pokemonDetailVC.pokemon = apiController.pokemon[indexPath.row]
            }
        }
        
        else if segue.identifier == "PokemonSearchShowSegue" {
            if let pokemonSearchVC = segue.destination as? PokemonDetailViewController {
                pokemonSearchVC.apiController = apiController
            }
        }
    }
}
