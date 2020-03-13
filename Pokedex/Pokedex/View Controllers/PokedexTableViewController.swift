//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    
    // MARK: - Private
    private let pokeApiClient = PokeApiClient()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        // Configure the cell...

        return cell
    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonSearchVC = segue.destination as? PokemonSearchViewController {
            pokemonSearchVC.pokeApiClient = pokeApiClient
        }
    }


}
