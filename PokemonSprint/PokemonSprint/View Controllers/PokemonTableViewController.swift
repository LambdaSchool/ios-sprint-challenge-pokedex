//
//  PokemonTableViewController.swift
//  PokemonSprint
//
//  Created by Elizabeth Wingate on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: - Properties

    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        guard indexPath.row < pokemonController.pokemonList.count else { return cell }

        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //guard let cell = tableView.cellForRow(at: indexPath) else { return }
            pokemonController.pokemonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonDetail" {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard indexPath.row < pokemonController.pokemonList.count else { return }

            let pokemon = self.pokemonController.pokemonList[indexPath.row]
            pokemonSearchVC.pokemonController = self.pokemonController
            pokemonSearchVC.pokemon = pokemon
            pokemonSearchVC.navigationItem.title = pokemon.name.capitalized

        } else if segue.identifier == "ShowPokemonSearch" {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }

            pokemonSearchVC.pokemonController = self.pokemonController
        }
    }

}
