//
//  SavedTableViewController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class SavedTableViewController: UITableViewController {
    
    private let apiController = APIController()
    private var pokemon: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchVC = segue.destination as? SearchViewController {
            searchVC.apiController = apiController
            searchVC.delegate = self
        } else if let pokemonVC = segue.destination as? PokemonViewController {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            pokemonVC.apiController = apiController
            pokemonVC.pokemon = pokemon[index]
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPokemonCell", for: indexPath)

        cell.textLabel?.text = pokemon[indexPath.row].name.capitalized

        return cell
    }
}

extension SavedTableViewController: SearchDelegate {
    
    func save(_ pokemon: Pokemon) {
        self.pokemon.append(pokemon)
    }
}
