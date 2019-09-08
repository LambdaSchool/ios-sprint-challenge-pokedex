//
//  PokedexTableViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name.capitalized
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchShowSegue" {
            if let searchVC = segue.destination as? PokemonSearchViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "PokemonDetailShowSegue" {
            if let detailVC = segue.destination as? PokemonDetailsViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemon = pokemonController.pokemons[indexPath.row]
            }
        }
    }
}




