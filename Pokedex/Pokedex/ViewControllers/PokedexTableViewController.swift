//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    private var pokemons: [Pokemon] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemonController.pokemonArray[indexPath.row].name.capitalized
        cell.detailTextLabel?.text = String(pokemonController.pokemonArray[indexPath.row].id)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearch" {
            guard let destinationVC = segue.destination as? SearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ToDetail" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemonArray[index.row]
            destinationVC.pokemon = pokemon
        }
    }


}
