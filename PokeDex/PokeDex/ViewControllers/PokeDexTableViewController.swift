//
//  PokeDexTableViewController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class PokeDexTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    
    // MARK: - Methods
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifier.segueName.addPokemon.rawValue {
            guard let addVC = segue.destination as? SearchViewController else { return }
            addVC.pokemonController = pokemonController
            
        } else if segue.identifier == SegueIdentifier.segueName.showPokemon.rawValue {
            guard let showVC = segue.destination as? SearchViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            showVC.pokemonController = pokemonController
            showVC.pokemon = pokemonController.pokeDex[indexPath.row]
        }
    }
}
