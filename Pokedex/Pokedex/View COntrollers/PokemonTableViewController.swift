//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let currentPokemon = pokemonController.pokemon[indexPath.row]
        
        cell.textLabel?.text = currentPokemon.name

        return cell
    }
    
    // MARK: - Swipe to Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.delete(indexOfPokemon: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }

    // MARK: - prepare(for segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearch" {
            let searchVC = segue.destination as? SearchPokemonViewController
            searchVC?.pokemonController = pokemonController
        }
        else if segue.identifier == "ShowDetal" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as? SearchPokemonViewController
                detailVC?.pokemonController = pokemonController
                detailVC?.pokemon = pokemonController.pokemon[indexPath.row]
            }
        }
    }


}
