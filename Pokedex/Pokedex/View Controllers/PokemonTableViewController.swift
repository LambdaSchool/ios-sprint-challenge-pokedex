//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Norlan Tibanear on 7/18/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    
    var pokemonController = PokemonController()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon List"
        tableView.reloadData()
    }
    
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

        let pokemon = pokemonController.savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name

        return cell
    }
    
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        let pokemon = pokemonController.savedPokemon[indexPath.row]
        if editingStyle == .delete {
            pokemonController.removePokemon(pokemon: pokemon)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
// Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            if let searchVC = segue.destination as? PokemonDetailViewController {
                searchVC.pokemonController = pokemonController
                
            }
        } else if segue.identifier == "ViewPokemonSegue" {
            if let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let pokemon = pokemonController.savedPokemon[indexPath.row]
                detailVC.pokemon = pokemon
                detailVC.pokemonController = pokemonController
            }
        }
    }

    
} //
