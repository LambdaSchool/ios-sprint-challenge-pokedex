//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Vincent Hoang on 5/8/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonList: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "pokemonTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel!.text = pokemonList[indexPath.row].name.capitalized
        
        return cell
    }
    
    @IBAction func unwindToPokemonTable(_ sender: UIStoryboardSegue) {
        guard let sourceViewController = sender.source as? PokemonDetailViewController else {
            return
        }
        
        if let newPokemon = sourceViewController.pokemon {
            pokemonList.append(newPokemon)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSegue" {
            guard let pokemonDetailViewController = segue.destination as? PokemonDetailViewController else {
                return
            }
            
            guard let selectedPokemon = sender as? UITableViewCell else {
                return
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPokemon) else {
                return
            }
            
            pokemonDetailViewController.pokemon = pokemonList[indexPath.row]
        }
    }

}
