//
//  PokemonListTableViewController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    
    
    let pokemonController = PokemonController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        
        // Configure the cell...
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }
    
    
    
    
}
