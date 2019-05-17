//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    } // end of view did load
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemon.count
    } // end of number of rows

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        // implement pokemon sprite
        return cell
    } // end of cell for row at

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    } // end of delete cell

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let pokemonDVC = segue.destination as? PokemonDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    pokemonDVC.pokemon = pokemonController.pokemon[indexPath.row]
                }
                pokemonDVC.pokemonController = pokemonController
            }
            else if segue.identifier == "SearchSegue" {
                if let pokemonSVC = segue.destination as? PokemonSearchViewController {
                    pokemonSVC.pokemonController = pokemonController
                }
            }
        }
    } // end of prepare for segue
}
