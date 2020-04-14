//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Gi Pyo Kim on 10/4/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

enum SortType: Int {
    case name = 0
    case id = 1
}

class PokedexTableViewController: UITableViewController {
    
    @IBOutlet weak var sortTypeSegment: UISegmentedControl!
    
    let pokemonController = PokemonController()
    var sortType: SortType!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sortSavedPokemons()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        cell.textLabel?.text = pokemonController.savedPokemons[indexPath.row].name.capitalized
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchDetailViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? SearchDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemonController = pokemonController
                detailVC.pokemon = pokemonController.savedPokemons[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            pokemonController.savedPokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func sortSavedPokemons() {
        if sortTypeSegment.selectedSegmentIndex == 0 {
            sortType = .name
        } else {
            sortType = .id
        }
        pokemonController.sortPokemon(by: sortType)
        tableView.reloadData()
    }
    
    @IBAction func sortValueChanged(_ sender: UISegmentedControl) {
        sortSavedPokemons()
    }
}
