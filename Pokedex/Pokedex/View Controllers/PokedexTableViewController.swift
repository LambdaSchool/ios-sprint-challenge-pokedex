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
    private let pokedex = Pokedex()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedex.pokemon.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokedex.pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokedex.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonSearchVC = segue.destination as? PokemonSearchViewController {
            pokemonSearchVC.pokeApiClient = pokeApiClient
            pokemonSearchVC.pokedex = pokedex
        }
        
        if let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            pokemonDetailVC.pokeApiClient = pokeApiClient
            pokemonDetailVC.pokemon = pokedex.pokemon[indexPath.row]
        }
    }


}
