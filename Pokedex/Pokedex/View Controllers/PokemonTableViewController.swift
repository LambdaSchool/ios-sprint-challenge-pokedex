//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/24/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { fatalError("Unable to dequeue cell")}

        let pokemon = pokemonController.savedPokemon[indexPath.row]
        cell.pokemon = pokemon
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.savedPokemon.remove(at: indexPath.row)
            pokemonController.saveToPersistentStore()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchButtonSegue" {
            guard let destinationVC = segue.destination as? SearchDetailViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "PokemonCellSegue" {
            guard let destinationVC = segue.destination as? SearchDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemonController.savedPokemon[indexPath.row]
        }
    }
 
   var pokemonController = PokemonController()

}
