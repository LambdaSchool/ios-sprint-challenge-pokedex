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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon" {
            let destinationVC = segue.destination as! AddPokemonViewController
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowPokemon" {
            let destinationVC = segue.destination as! PokemonDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokemons[indexPath.row]
            destinationVC.pokemonController = pokemonController
        }
    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! pokemonTableViewCell
        cell.pokemon = pokemonController.pokemons[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            pokemonController.pokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }



}
