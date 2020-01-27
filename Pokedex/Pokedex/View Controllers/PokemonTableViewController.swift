//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // MARK: - Properties
    
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
        return pokemonController.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        cell.textLabel?.text = pokemonController.savedPokemon[indexPath.row].name.capitalized

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokemonController.deletePokemon(pokemonController.savedPokemon[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
                pokemonDetailVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "DetailSegue" {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                pokemonDetailVC.pokemonController = pokemonController
                pokemonDetailVC.pokemon = pokemonController.savedPokemon[indexPath.row]
            }
        }
        
        
        
        
        
    }

}
