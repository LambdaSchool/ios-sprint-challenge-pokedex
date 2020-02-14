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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellKeys.cellIdentifier.pokeDexTableVCCell.rawValue,
                                                 for: indexPath)
        guard pokemonController.pokeDex.count > 0 else {return UITableViewCell()}
        cell.textLabel?.text = pokemonController.pokeDex[indexPath.row].name
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
