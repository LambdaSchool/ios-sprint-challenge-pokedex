//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // MARK: - Properties
    let pokemonController = PokemonController()
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokedexSortedByID[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        cell.detailTextLabel?.text = "\(pokemon.id)"
        if let imageData = pokemon.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokedexSortedByID[indexPath.row]
            
            pokemonController.deletePokemon(pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemonSegue" {
            let destinationVC = segue.destination as! PokemonDetailViewController
            
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowPokemonSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokedexSortedByID[indexPath.row]
            
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemon
            
        }
    }
    

}
