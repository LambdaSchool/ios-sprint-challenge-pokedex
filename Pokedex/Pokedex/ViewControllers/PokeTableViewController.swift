//
//  PokeTableViewController.swift
//  Pokedex
//
//  Created by Bradley Diroff on 3/13/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class PokeTableViewController: UITableViewController {
    
    let searchController = SearchController()
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.allPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if let text = searchController.allPokemon[indexPath.row].forms.first {
            cell.textLabel?.text = text.name.capitalizingFirstLetter()
        }

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchSegue" {
            if let vc = segue.destination as? PokeDetailViewController {
                vc.searchController = searchController
                vc.delegate = self
            }
        }
        
        if segue.identifier == "showSegue" {
            if let vc = segue.destination as? PokeDetailViewController {
                vc.searchController = searchController
                vc.delegate = self
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.pokemon = searchController.allPokemon[indexPath.row]
                }
            }
        }
        
    }
}

extension PokeTableViewController: AddPokemonDelegate {
    func pokemonWasAdded(_ pokemon: Pokemon) {
        searchController.addPokemon(pokemon)
        tableView.reloadData()
    }
    
}
