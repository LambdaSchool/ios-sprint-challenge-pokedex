//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokemons[indexPath.row]
            
            // Delete the row from the data source
            pokemonController.delete(pokemon: pokemon)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set up the prepare segway to the search controller
        if let searchVC = segue.destination as? SearchPokemonViewController {
            searchVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "ShowPokemonDetail" {
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let pokemon = pokemonController.pokemons[index]
            
            detailVC.pokemon = pokemon
        }
    }
    

}
