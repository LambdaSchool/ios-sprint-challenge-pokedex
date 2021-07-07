//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - TableView data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokeDex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let searchResult = pokemonController.pokeDex[indexPath.row]
        cell.textLabel?.text = searchResult.name.capitalized
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokeDex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let pokemon = pokemonController.pokeDex[indexPath.row]
            destinationVC.pokemon = pokemon
        }
        
        if segue.identifier == "Search" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        }
    }
}
