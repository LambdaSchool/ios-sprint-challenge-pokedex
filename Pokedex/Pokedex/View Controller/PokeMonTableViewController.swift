//
//  PokeMonTableViewController.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class PokeMonTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokeMonTableViewCell else {return UITableViewCell()}
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.pokemon =  pokemon
        return cell
    }

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokemons[indexPath.row]
            pokemonController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDetail"{
            guard let detailVC = segue.destination as? PokeMonDetailViewController else {return}
            detailVC.pokeController = pokemonController
        }else if segue.identifier == "showDetail"{
            guard let detailVC = segue.destination as? PokeMonDetailViewController,
                let index = tableView.indexPathForSelectedRow else {return}
            detailVC.pokemon = pokemonController.pokemons[index.row]

        }
        
    }
    
    
    
    let pokemonController = PokemonController()

}
