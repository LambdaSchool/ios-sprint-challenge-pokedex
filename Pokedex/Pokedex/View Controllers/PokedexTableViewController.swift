//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Claudia Contreras on 3/20/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: - Properties
    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemon = pokemonController.savedPokemon[indexPath.row]
        if editingStyle == .delete {
            pokemonController.delete(pokemon: pokemon)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let searchPokemonVC = segue.destination as? PokemonDetailViewController {
                searchPokemonVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "showClickedPokemon" {
            if let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let pokemon = pokemonController.savedPokemon[indexPath.row]
                pokemonDetailVC.pokemon = pokemon
                pokemonDetailVC.pokemonController = pokemonController
            }
        }
    }


}
