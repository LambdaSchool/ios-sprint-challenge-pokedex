//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    
    let pokemonAPI = PokemonAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonAPI.pokemon.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        let pokemon = pokemonAPI.pokemon[indexPath.row]
        cell.pokemon = pokemon
        cell.pokemonAPI = self.pokemonAPI
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.pokemonAPI.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearchVC" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonAPI = pokemonAPI
            }
        }
        if segue.identifier == "ToDetailVC" {
            if let detailVC = segue.destination as? SearchViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let pokemon = pokemonAPI.pokemon[indexPath.row]
                detailVC.title = pokemon.name.capitalizingFirstLetter()
                detailVC.pokemon = pokemon
                detailVC.pokemonAPI = pokemonAPI
            }
        }
    }
}
