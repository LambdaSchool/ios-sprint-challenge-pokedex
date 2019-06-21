//
//  PokedexTableViewController.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokemons[indexPath.row]
            pokemonController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonSearchDetail" {
            guard let searchVC = segue.destination as? PokemonSearchViewController
                else { fatalError("Something really really bad just happened in your prepare segue for destination: \(segue.destination)") }
            
            searchVC.pokemonController = pokemonController
            pokemonController.pokemon = nil
        } else if segue.identifier == "ShowPokemonDetail" {
            guard let searchVC = segue.destination as? PokemonSearchViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { fatalError("Something really really bad just happened in your prepare segue for destination: \(segue.destination)") }
            
            pokemonController.pokemon = pokemonController.pokemons[indexPath.row]
            searchVC.pokemonController = pokemonController
            
        }
    }
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
}
