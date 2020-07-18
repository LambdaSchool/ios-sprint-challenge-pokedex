//
//  PokedexTableViewController.swift
//  Pokemon
//
//  Created by Cora Jacobson on 7/18/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pokemons = pokemonController.pokemonArray
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonArray.remove(at: indexPath.row)
            pokemonController.saveToPersistentStore()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailShowSegue" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.pokemonController = pokemonController
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
                }
            }
        } else if segue.identifier == "searchShowSegue" {
            if let searchVC = segue.destination as? DetailViewController {
                searchVC.pokemonController = pokemonController
            }
        }
    }

}
