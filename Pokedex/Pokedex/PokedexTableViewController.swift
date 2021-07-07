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
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
     
        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.deletePokemon(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Search" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            searchVC.pokemonController = pokemonController
        }
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController,
            let index = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonList[index.row]
        }
    }
    
    let pokemonController = PokemonController()

}
