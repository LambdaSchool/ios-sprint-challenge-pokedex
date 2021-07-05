//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 5/17/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    let pokedexController = PokedexController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokedexController.savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokedexController.savedPokemon[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        let url = URL(string: pokemon.image)!
        cell.imageView!.loadURL(url: url)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokedexController.savedPokemon[indexPath.row]
            pokedexController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonDetail" {
            guard let destinationVC = segue.destination as? PokemonViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.pokedexController = pokedexController
            destinationVC.pokemon = pokedexController.savedPokemon[indexPath.row]
            destinationVC.showDetail = true
            
        } else {
            guard let destinationVC = segue.destination as? PokemonViewController else { return }
            destinationVC.pokedexController = pokedexController
            destinationVC.showDetail = false
        }
    }
}
