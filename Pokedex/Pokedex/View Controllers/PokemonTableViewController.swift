//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.create(name: "Andrew", id: "00", abilities: "Eating", types: "Human")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name
        return cell
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon"{
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.pokemonController = pokemonController
        }
        if segue.identifier == "ViewPokemon"{
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.pokemonController = pokemonController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.pokemon = pokemonController.pokemons[indexPath.row]
        }

    }

    let pokemonController = PokemonController()
}
