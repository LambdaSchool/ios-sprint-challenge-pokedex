//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemons = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemons.name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokemonDetailViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "DetailSegue" {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
                pokemonDetailVC.pokemonController = pokemonController
                if let indexPath = tableView.indexPathForSelectedRow {
                    pokemonDetailVC.pokemon = pokemonController.pokemons[indexPath.row]
                }
            }
        }
    }
}
