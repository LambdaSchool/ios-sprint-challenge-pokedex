//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Lydia Zhang on 3/13/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
//    func mer() {
//        pokemonController.fetchPokemon(name: "eevee") {result in
//            
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        if editingStyle == .delete {
            pokemonController.deletePokemon(for: pokemon)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue" {
            guard let detailVC = segue.destination as? AddViewController, let indexpath = tableView.indexPathForSelectedRow else {
                return
            }
            let pokemon = self.pokemonController.pokemonArray[indexpath.row]
            detailVC.pokemonController = self.pokemonController
            detailVC.pokemon = pokemon
        } else if segue.identifier == "AddSegue" {
            guard let addVC = segue.destination as? AddViewController else {
                return
            }
            addVC.pokemonController = self.pokemonController
        }
    }
        
        
        
    
    

}
