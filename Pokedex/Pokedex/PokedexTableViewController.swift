//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        pokemonController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        pokemonController.loadFromPersistentStore()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchDetailVC = segue.destination as? DetailTableViewController {
                searchDetailVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? DetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let pokemon = pokemonController.savedPokemon[indexPath.row]
                detailVC.pokemon = pokemon
                detailVC.pokemonController = pokemonController
                
                
            }
        }
    }
}
