//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    //MARK: - Properties
    let pokemonAPI = PokemonAPIController()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonAPI.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonAPI.savedPokemon[indexPath.row].name.capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonAPI.savedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            pokemonAPI.saveToPersistentStore()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokedexSearchSegue" {
            if let searchVC = segue.destination as? PokedexSearchViewController {
                searchVC.pokemonAPI = pokemonAPI
            }
        } else if segue.identifier == "PokedexDetailSegue" {
            if let detailVC = segue.destination as? PokedexDetailViewController{
                guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
                let selectedPokemon = pokemonAPI.savedPokemon[selectedIndexPath.row]
                detailVC.pokemon = selectedPokemon
                detailVC.pokemonAPI = pokemonAPI
            }
        }
    }

}
