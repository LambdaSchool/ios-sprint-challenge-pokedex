//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  pokemonController.pokemonResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemonResults[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        
        return cell
    }
 


    var pokemonController = PokemonController()
    
}
