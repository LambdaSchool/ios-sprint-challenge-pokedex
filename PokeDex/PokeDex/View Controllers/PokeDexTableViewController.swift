//
//  PokeDexTableViewController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class PokeDexTableViewController: UITableViewController {
        
    let pokemonController = PokedexController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) 

        cell.textLabel?.text = pokemonController.savedPokemon[indexPath.row].name.capitalized
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.savedPokemon[indexPath.row]
            pokemonController.removeSavedPokemon(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearch" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ViewPokemon" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemonController.savedPokemon[indexPath.row]
            
        }
    }
   

}
