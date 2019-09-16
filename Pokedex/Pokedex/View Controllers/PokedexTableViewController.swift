//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    //MARK: - Properties
    var savedPokemon: [Pokemon] = []
    let pokemonAPI = PokemonAPIController()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokedexSearchSegue" {
            if let searchVC = segue.destination as? PokedexSearchViewController {
                searchVC.pokemonAPI = pokemonAPI
            }
        } else if segue.identifier == "PokedexDetailSegue" {
            
        }
    }

}
