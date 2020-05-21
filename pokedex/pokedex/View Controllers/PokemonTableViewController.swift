//
//  PokemonTableViewController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // Properties
    let pokemonAPIController = PokemonAPIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
// 1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonAPIController.pokedex.count
    }

// 2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else
       { return UITableViewCell() }
        let pokemon = pokemonAPIController.pokedex[indexPath.row]
        cell.pokemon = pokemon
        
        

        return cell
    }
   

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
            destinationVC.pokemonAPIController = pokemonAPIController
        } else if segue.identifier == "PokemonDetailSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemon = pokemonAPIController.pokedex[indexPath.row]
            detailVC.pokemonAPIController = pokemonAPIController
        }
    }
}
extension PokemonTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonAPIController.pokedex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
