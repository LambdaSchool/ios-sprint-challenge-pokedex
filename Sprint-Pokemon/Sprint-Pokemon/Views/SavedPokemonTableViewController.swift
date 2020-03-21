//
//  SavedPokemonTableViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class SavedPokemonTableViewController: UITableViewController {
    
    // MARK: - Properties
    let pokemonController = PokemonController()
    var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemons[indexPath.row].name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "ShowDetailSegue",
             let detailVC = segue.destination as? PokemonSearchViewController,
             let selectedIndexPath = tableView.indexPathForSelectedRow {
             detailVC.pokemonController = pokemonController
             detailVC.pokemon = pokemons[selectedIndexPath.row]
         } else if segue.identifier == "SearchSegue",
             let addVC = segue.destination as? PokemonSearchViewController {
             addVC.pokemonController = pokemonController
         }
     }
}

