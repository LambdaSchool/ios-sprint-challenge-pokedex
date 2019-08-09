//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Nathan Hedgeman on 8/9/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    //Properties
    let pokemonController = PokemonController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name
        
        return cell
    }
    
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "PokemonSearchSegue" {
            
            guard let searchVC = segue.destination as? PokemonSearchViewViewController else { return }
            searchVC.pokemonController = pokemonController
            
        } else if segue.identifier == "PokemonDetailSegue" {
            
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            detailVC.pokemonController = pokemonController
            
            guard let selected = self.tableView.indexPathForSelectedRow?.row else { return }
            detailVC.pokemon = pokemonController.pokemonList[selected]
        }
    }
    
}
