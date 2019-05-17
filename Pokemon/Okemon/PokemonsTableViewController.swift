//
//  PokemonsTableViewController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class PokemonsTableViewController: UITableViewController {
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemon" {
            let destinationVC = segue.destination as! AddPokemonViewController
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowPokemon" {
            let destinationVC = segue.destination as! PokemonDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokemons[indexPath.row]
            
        }
    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]

        cell.textLabel?.text = pokemon.name


        return cell
    }



}
