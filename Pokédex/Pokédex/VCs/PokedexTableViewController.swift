//
//  PokédexTableViewController.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.delete(pokemon: pokemonController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Properties
    
    var pokemonController = PokemonController()
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearch" {
            let destVC = segue.destination as! PokemonSearchViewController
            destVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowDetails" {
            let destVC = segue.destination as! PokemonDetailViewController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            destVC.pokemon = pokemonController.pokemons[index]
            destVC.pokemonController = pokemonController
        }
    }

}
