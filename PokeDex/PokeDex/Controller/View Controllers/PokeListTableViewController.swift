//
//  PokeListTableViewController.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class PokeListTableViewController: UITableViewController {
    
    var pokemonController = PokemonTrainer()
    var savedPokemon: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.getPokemonData { (error) in
            let pokemon = self.pokemonController.pokeDataArray[0]
            let url = URL(string: pokemon.url)
            self.pokemonController.getPokemonFromURL(url: url) { (pokemon) in
                guard let pokemon = pokemon else {return}
                DispatchQueue.main.async {
                    self.savedPokemon.append(pokemon)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegue" {
            guard let destination = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            destination.pokemon = savedPokemon[indexPath.row]
            destination.pokemonController = pokemonController
        }
    }
   

}
