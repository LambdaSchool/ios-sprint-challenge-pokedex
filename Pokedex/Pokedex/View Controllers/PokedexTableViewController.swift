//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.myPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let pokemon = pokemonController.myPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let pokemon = pokemonController.myPokemon[indexPath.row]
            pokemonController.removePokemon(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Search" {
            guard let destinationVC = segue.destination as? SearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        }
        else if segue.identifier == "Pokemon Details" {
            guard let destinationVC = segue.destination as? PokedexDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.myPokemon[indexPath.row]
            destinationVC.pokemon = pokemon
        }
    }

}
