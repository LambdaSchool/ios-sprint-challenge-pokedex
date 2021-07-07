//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Casualty on 9/15/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    var pokemonCell: String = "PokemonCell"
    var showPokemonSegue: String = "ShowPokemonSegue"
    var apiController = APIController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController = APIController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCell, for: indexPath)
        let pokemon = apiController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonSearchVC = segue.destination as? SearchViewController {
            pokemonSearchVC.apiController = apiController
            
            if segue.identifier == showPokemonSegue, let indexPath = tableView.indexPathForSelectedRow {
                pokemonSearchVC.searchPokemon = apiController.pokemons[indexPath.row]
            }
        }
    }
}
