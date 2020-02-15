//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController, PokemonDetailVCDelegate {
      func didReceivePokemon(pokemon: Pokemon) {
            tableView.reloadData()
        }
        
        //MARK: Properties
        let pokemonController = PokemonController()
        
        // MARK: View Lifecycle
       
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.reloadData()
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }

        // MARK: - Table view data source
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemonController.pokemonArray.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
            let pokemon = pokemonController.pokemonArray[indexPath.row]
            cell.textLabel?.text = pokemon.name?.capitalized
            return cell
            
        }
        
          
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                self.pokemonController.pokemonArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

        
        // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SearchSegue" {
                guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
                destinationVC.pokemonController = pokemonController
                destinationVC.delegate = self
            } else if segue.identifier == "DetailSegue" {
                guard let detailVC = segue.destination as? PokemonDetailViewController , let indexPath = tableView.indexPathForSelectedRow else { return }
                detailVC.pokemonController = pokemonController
                detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
            }
        }
}
