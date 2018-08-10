//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Vuk Radosavljevic on 8/10/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    //MARK: - Properties
    let pokemonController = PokemonController()
    
    
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemon.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokemon[indexPath.row]
            pokemonController.delete(thePokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowDetails":
            let destinationVC = segue.destination as! PokemonDetailViewController
            guard let index = tableView.indexPathForSelectedRow?.row else {return}
            destinationVC.pokemonController = pokemonController
            let pokemon = pokemonController.pokemon[index]
            destinationVC.pokemon = pokemon
            destinationVC.navigationItem.title = pokemon.name
            destinationVC.searchBarHidden = true
        case "Search":
            let destinationVC = segue.destination as! PokemonDetailViewController
            destinationVC.pokemonController = pokemonController
            destinationVC.searchBarHidden = false
        default:
            break
        }
    }

}
