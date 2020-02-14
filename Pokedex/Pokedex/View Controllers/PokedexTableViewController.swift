//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchViewControllerSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
            }
            
        } else if segue.identifier == "ShowDetailViewSegue" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    detailVC.pokemon = pokemonController.pokemen[selectedIndex.row]
                    detailVC.pokemonController = pokemonController
                    detailVC.isButtonHidden = true
                    
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemen.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.pokemen[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
}
