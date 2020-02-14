//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 14/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonShowSegue" {
            if let searchPokemonVC = segue.destination as? PokemonDetailViewController {
                searchPokemonVC.pokemonController = pokemonController
            }
            
            else if segue.identifier == "PokemonDetailShowSegue" {
                if let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
                    let indexPath = tableView.indexPathForSelectedRow {
                    let pokemon = pokemonController.pokemonList[indexPath.row]
                    pokemonDetailVC.pokemon = pokemon
                }
            }
        }
    }
}
