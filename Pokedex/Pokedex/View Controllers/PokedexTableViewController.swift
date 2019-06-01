//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Michael Stoffer on 6/1/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = self.pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearchPokemon" {
            guard let pokemonDVC = segue.destination as? PokemonDetailViewController else { return }
            pokemonDVC.pokemonController = self.pokemonController
        }
    }
}
