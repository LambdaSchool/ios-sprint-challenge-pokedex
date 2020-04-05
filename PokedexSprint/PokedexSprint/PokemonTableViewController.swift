//
//  PokemonTableViewController.swift
//  PokedexSprint
//
//  Created by Lambda_School_Loaner_241 on 3/27/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.pokemonArray[indexPath.row].name.capitalized

        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let pokemon = pokemonController.pokemonArray[indexPath.row]
            
            pokemonController.removePokemon(pkmn: pokemon)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearch"{
            
            guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
            
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "PokemonSegue" {
            
            guard let destinationVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.pokemonController = pokemonController
            
            destinationVC.pokemon = pokemonController.pokemonArray[indexPath.row]
        }
    }
    

    
}
