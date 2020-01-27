//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Joshua Rutkowski on 1/26/20.
//  Copyright © 2020 Josh Rutkowski. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokedexController = PokedexController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedexController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokedexController.pokemons[indexPath.row].name
        return cell
    }
    
    // Delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokedexController.delete(pokedexController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemonSegue" {
            if let addVC = segue.destination as? PokedexDetailViewController {
                addVC.pokedexController = pokedexController
            }
        } else if segue.identifier == "PokemonDetailSegue" {
            if let detailVC = segue.destination as? PokedexDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokedexController = pokedexController
                detailVC.pokemon = pokedexController.pokemons[indexPath.row]
            }
        }
    }

    
}
