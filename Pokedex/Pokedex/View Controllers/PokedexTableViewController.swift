//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Bronson Mullens on 5/15/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Properties
    var pokemonController = PokemonController()

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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemon" {
            if let searchVC = segue.destination as? PokemonDetailViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "PokemonDetail" {
            if let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let pokemon = pokemonController.savedPokemon[indexPath.row]
                detailVC.pokemon = pokemon
                detailVC.pokemonController = pokemonController
            }
        }
    }

}
