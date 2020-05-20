//
//  PokemonTableViewController.swift
//  PokemonScondAttempt
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonInPokedex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        guard let pokemonCell = cell as? PokemonTableViewCell else { return cell }
        
        pokemonCell.pokemon = pokemonController.pokemonInPokedex[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            pokemonController.pokemonInPokedex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddSegue" {
            guard let destinationVC = segue.destination as? PokemonViewController else { return }
            destinationVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "DetailSegue" {
            guard let destinationVC = segue.destination as? PokemonViewController else { return }
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemonController.pokemonInPokedex[index]
          
        }
    }
    
}
