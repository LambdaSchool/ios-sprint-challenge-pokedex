//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    let pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokedexSortedByName[indexPath.row]

        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = "\(pokemon.id)"
        if let imageData = pokemon.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokedexSortedByName[indexPath.row]
        
            pokemonController.deletePokemon(pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonSearch" {
            let searchVC = segue.destination as! PokemonSearchViewController
            searchVC.pokemonController = pokemonController
        }
        if segue.identifier == "ShowPokemonDetail" {
            let detailVC = segue.destination as! PokemonDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
    

}
