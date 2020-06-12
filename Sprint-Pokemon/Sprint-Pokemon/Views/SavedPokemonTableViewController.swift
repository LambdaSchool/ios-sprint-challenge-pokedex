//
//  SavedPokemonTableViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class SavedPokemonTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.loadFromPersistentStore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            pokemonController.saveToPersistentStore()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue",
            let detailVC = segue.destination as? PokemonSearchViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemons[selectedIndexPath.row]
        } else if segue.identifier == "SearchSegue",
            let addVC = segue.destination as? PokemonSearchViewController {
            addVC.pokemonController = pokemonController
        }
    }
}

