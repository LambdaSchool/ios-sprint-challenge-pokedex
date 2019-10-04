//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    private var pokemon: [String] = []
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemon.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemon[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPokemon" {
            if let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                detailVC.pokemonController = pokemonController
                detailVC.pokemon = pokemon[indexPath.row]
            }
        }
    }
    
}
