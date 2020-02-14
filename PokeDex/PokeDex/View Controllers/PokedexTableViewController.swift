//
//  PokedexTableViewController.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    //MARK: - Variables
    let pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonSearchViewController, let indexpath = tableView.indexPathForSelectedRow else { return }
            let pokemon = self.pokemonController.pokemonList[indexpath.row]
            pokemonDetailVC.pokemonController = self.pokemonController
            pokemonDetailVC.pokemon = pokemon
        } else if segue.identifier == "PokemonSearchSegue" {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
            pokemonSearchVC.pokemonController = self.pokemonController
        }
    }
}
