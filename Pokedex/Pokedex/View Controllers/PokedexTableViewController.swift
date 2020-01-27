//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: - Properties

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
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexTableViewCell", for: indexPath)
        guard indexPath.row < pokemonController.pokemonList.count else { return cell }
        
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonDetail" {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard indexPath.row < pokemonController.pokemonList.count else { return }
            
            let pokemon = self.pokemonController.pokemonList[indexPath.row]
            pokemonSearchVC.pokemonController = self.pokemonController
            pokemonSearchVC.pokemon = pokemon
            pokemonSearchVC.navigationItem.title = pokemon.name.capitalized
            
        } else if segue.identifier == "ShowPokemonSearch" {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
            
            pokemonSearchVC.pokemonController = self.pokemonController
        }
    }

}
