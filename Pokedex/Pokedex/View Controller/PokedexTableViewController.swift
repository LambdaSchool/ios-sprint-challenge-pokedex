//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var apiController = APIController()
    private var pokemonNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonNames[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue",
            let searchVC = segue.destination as? PokeSearchViewController {
            searchVC.apiController = apiController
        }
    }
    

}
