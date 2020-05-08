//
//  PokemonTableViewController.swift
//  PokedexSprint_iOS17
//
//  Created by Stephanie Ballard on 5/8/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // MARK: - Properties -
    let pokemonApiController = PokemonApiController()
    
    // MARK: - LifeCycle Functions -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonApiController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        let pokemon = pokemonApiController.pokedex[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchShowSegue" {
            guard let destination = segue.destination as? PokemonDetailViewController else { return }
            destination.pokemonApiController = pokemonApiController
        } else if segue.identifier == "PokemonCellShowSegue" {
            guard let destination = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.pokemon = pokemonApiController.pokedex[indexPath.row]
            
        }
    }
}

extension PokemonTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonApiController.pokedex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
