//
//  PokedexTableViewController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            if let vc = segue.destination as? PokedexSearchViewController {
                vc.pokemonController = pokemonController
            }
        } else if segue.identifier == "ShowPokemonDetailSegue" {
            if let vc = segue.destination as? PokemonDetailViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.pokemon = pokemonController.pokemons[indexPath.row]
                }
            }
        }
    }
    
    let pokemonController = PokemonController()
}
