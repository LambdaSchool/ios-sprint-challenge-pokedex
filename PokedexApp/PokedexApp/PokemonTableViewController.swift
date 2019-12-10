//
//  PokemonTableViewController.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonApiController = PokemonAPIController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let thisPokemon = pokemonApiController.pokemons[indexPath.row]
        
        cell.textLabel?.text = thisPokemon.name
        cell.detailTextLabel?.text = "id \(thisPokemon.id)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonApiController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonApiController.delete(pokemonApiController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokemonDetialViewController {
                searchVC.pokemonApiController = pokemonApiController
            }
        }
        
        if segue.identifier == "ShowDetailView" {
            if let detailVC = segue.destination as? PokemonDetialViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemonApiController = pokemonApiController
                detailVC.pokemon = pokemonApiController.pokemons[indexPath.row]
            }
        }
    }
    

}
