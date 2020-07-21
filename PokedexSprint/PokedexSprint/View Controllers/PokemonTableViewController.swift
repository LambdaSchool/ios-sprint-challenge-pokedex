//
//  PokemonTableViewController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    //Properties
    let pokemonDataController = PokemonDataController()
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDataController.loadFromPersistenceStore()
        self.tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pokemonDataController.loadFromPersistenceStore()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonDataController.pokemonArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = pokemonDataController.pokemonArray[indexPath.row].pokemonName.capitalizingFirstLetter()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemon = pokemonDataController.pokemonArray[indexPath.row]
        
         if editingStyle == .delete {
             pokemonDataController.removePokemon(pokemon: pokemon)
         }
        tableView.deleteRows(at: [indexPath], with: .automatic)
     }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "search" {
            let destinationVC = segue.destination as? PokeSearchViewController
            print("Success Segue")
            destinationVC?.pokemonDataController = pokemonDataController
            destinationVC?.pokemonController = pokemonController
        } else if segue.identifier == "detail" {
            guard let destinationVC = segue.destination as? PokeSearchViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.pokemonDataController = pokemonDataController
            destinationVC.pokemonController = pokemonController
            let pokemon = self.pokemonDataController.pokemonArray[indexPath.row]
            destinationVC.pokemon = pokemon
        }
        
    }

}
