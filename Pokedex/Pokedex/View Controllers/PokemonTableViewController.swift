//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    var pokemonList: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemon = pokemonList[indexPath.row]
            }
        }
    }
}

extension PokemonTableViewController: UpdatePokedex {
    func savePokemonToPokedex(pokemon: Pokemon) {
        pokemonList.append(pokemon)
        dismiss(animated: true, completion: nil)
        self.tableView.reloadData()
    }
}
