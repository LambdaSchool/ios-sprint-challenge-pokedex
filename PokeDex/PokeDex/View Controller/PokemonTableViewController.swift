//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController, PokemonSavedDelegate {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pokemonWasSaved(pokemon: Pokemon) {
        pokemonController.pokemons.append(pokemon)
        tableView.reloadData()
    }
        
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { fatalError("The cell's identifier is wrong or could not be case correctly")}
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.pokemon = pokemon
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let viewPokemonVC = segue.destination as? PokemonDetailViewController else { return }
            viewPokemonVC.pokemonController = pokemonController
            viewPokemonVC.delegate = self
        } else {
            if segue.identifier == "DetailSegue" {
                guard let viewPokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
                if let indexPath = tableView.indexPathForSelectedRow {
                    let pokemon = pokemonController.pokemons[indexPath.row]
                    viewPokemonDetailVC.pokemon = pokemon
                    viewPokemonDetailVC.pokemonController = pokemonController
                    viewPokemonDetailVC.delegate = self
                }
            }
        }
    }
}
