//
//  PokedexTableViewController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            if let vc = segue.destination as? PokedexSearchViewController {
                vc.pokemonController = pokemonController
            }
        }
    }
    
    let pokemonController = PokemonController()
}
