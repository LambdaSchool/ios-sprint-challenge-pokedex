//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    //MARK: -Properties-
    
    var pokemonController = PokemonController()
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let name = pokemonController.pokemonList[indexPath.row].name
        cell.textLabel?.text = name

        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
