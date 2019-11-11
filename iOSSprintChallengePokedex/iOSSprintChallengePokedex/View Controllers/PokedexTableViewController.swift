//
//  PokedexTableViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonnCell", for: indexPath)
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = String(pokemon.id)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon" {
            let searchVC = segue.destination as? PokemonDetailViewController
            searchVC?.pokemonController = pokemonController
        } else if segue.identifier == "ViewPokemon" {
            guard let pokeDVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemons[indexPath.row]
            pokeDVC.pokemonController = pokemonController
            pokeDVC.pokemon = pokemon
        }
    }
    

}
