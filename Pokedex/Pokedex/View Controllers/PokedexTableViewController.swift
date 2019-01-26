//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }
    
    let reuseIdentifier = "PokemonCell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let pokemon = pokemonController.pokedex[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        
//        pokemonController.fetchImage(for: pokemon, completion: { (data) in
//            guard let data = data else { return }
//            let image = UIImage(data: data)
//            cell.imageView?.image = image
//            tableView.reloadData()
//        })

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemon = pokemonController.pokedex[indexPath.row]
        if editingStyle == .delete {
            pokemonController.deletePokemon(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon" {
            guard let destination = segue.destination as? SearchPokemonViewController else { return }
            destination.pokemonController = pokemonController
            
        } else if segue.identifier == "PokemonDetail" {
            guard let destination = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }

            destination.pokemonController = pokemonController
            destination.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    let pokemonController = PokemonController()
}
