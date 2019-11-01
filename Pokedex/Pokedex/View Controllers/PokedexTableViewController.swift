//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemon[indexPath.row].name.capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let byePokemon = pokemonController.pokemon[indexPath.row]
            pokemonController.deletePokemon(thePokemon: byePokemon)
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
                searchVC.pokemon = pokemonController.pokemon[indexPath.row]
            }
        }
    }
}
