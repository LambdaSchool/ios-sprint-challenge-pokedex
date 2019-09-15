//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            destinationVC.pokemonController = pokemonController
            destinationVC.delegate = self
        } else if segue.identifier == "ShowDetailSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokemons[indexPath.row]
            destinationVC.pokemonController = pokemonController
        }
    }
    
}

extension PokemonTableViewController: SearchPokemonDetailsDelegate {
    func save(pokemon: Pokemon) {
        pokemonController.pokemons.append(pokemon)
        tableView.reloadData()
    }
}
