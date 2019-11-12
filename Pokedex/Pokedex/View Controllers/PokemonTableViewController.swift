//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // pokemonController is initialized here and passed to the detail view controller
    var pokemonController = PokemonController()
    var pokemons: [Pokemon]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name
        cell.detailTextLabel?.text = String(pokemonController.pokemons[indexPath.row].id)

        return cell
    }
    
    // Swipe to delete from the table view
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        pokemonController.pokemons.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let pokeSearchVC = segue.destination as? PokemonSearchDetailViewController else { return }
            pokeSearchVC.pokemonController = pokemonController
            pokeSearchVC.delegate = self
        } else if segue.identifier == "PokemonDetailSegue" {
            guard let pokeDetailVC = segue.destination as? PokemonSearchDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            pokeDetailVC.delegate = self
            pokeDetailVC.pokemonController = pokemonController
            pokeDetailVC.pokemon = pokemonController.pokemons[indexPath.row]
        }
    }

}

//MARK: Extensions

extension PokemonTableViewController: AddPokemonDelegate {
    func pokeWasAdded(_ pokemons: [Pokemon]) {
        self.pokemons = pokemons
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
