//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
     
        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Search" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            searchVC.pokemonController = pokemonController
        }
    }
    
    let pokemonController = PokemonController()

}
