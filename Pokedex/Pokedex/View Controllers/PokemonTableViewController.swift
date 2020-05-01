//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        // Configure the cell...
        let pokemon = self.pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = "ID: \(pokemon.id)"
        
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let pokemonToDelete = pokemonController.pokemons[indexPath.row]
            
            pokemonController.deletePokemon(pokemonToDelete)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if segue.identifier == "SearchSegue" {
            guard let destVC = segue.destination as? PokemonDetailViewController else {return}
            destVC.pokemonController = pokemonController
            
            guard let indexP = tableView.indexPathForSelectedRow else {return}
            destVC.pokemon = pokemonController.pokemons[indexP.row]
            
            
        }
        
    }
    

}
