//
//  PokedexTableViewController.swift
//  PokedexSprint
//
//  Created by Clayton Watkins on 5/15/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    //MARK: - Properties
    let pokemonController = PokemonController()
    
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.myPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.myPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalizingFirstLetter()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.deletePokemon(pokemon: pokemonController.myPokemon[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue"{
            guard let searchVC = segue.destination as? PokemonDetailViewController else { return }
            searchVC.pokemonController = pokemonController
            searchVC.title = "Pokémon Search"
        } else if segue.identifier == "PokemonDetailSegue"{
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.myPokemon[indexPath.row]
            detailVC.title = "Pokemon"
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemon
        }
    }
}
