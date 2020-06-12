//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // MARK: - Properites
    private let pokemonController = PokemonController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name.capitalized

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            pokemonController.saveToPersistentStore()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue",
            let searchVC = segue.destination as? PokemonSearchViewController {
            searchVC.pokemonController = pokemonController
            searchVC.delegate = self
        } else if segue.identifier == "PokemonDetailSegue",
            let detailVC = segue.destination as? PokemonSearchViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            detailVC.pokemonController = pokemonController
            detailVC.title = "\(pokemonController.pokemonList[selectedIndexPath.row])"
            detailVC.pokemon = pokemonController.pokemonList[selectedIndexPath.row]
            print("\(pokemonController.pokemonList[selectedIndexPath.row])")
        }
    }
}

extension PokemonTableViewController : PokemonDelegate {
    func pokemonSaved() {
        tableView.reloadData()
    }
}
