//
//  PokeListTableViewController.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class PokeListTableViewController: UITableViewController {
    //MARK: Class Properties
    var pokemonController = PokemonTrainer()
    var savedPokemon: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.getPokemonData { (error) in
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(pokemonController.pokemon)
        savedPokemon = pokemonController.pokemon
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegue" {
            guard let destination = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            destination.pokemon = savedPokemon[indexPath.row]
            destination.pokemonController = pokemonController
        }
        if segue.identifier == "PokemonSearchSegue" {
            guard let destination = segue.destination as? DetailViewController else {return}
            destination.pokemonController = pokemonController
        }
    }
}
