//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.savedPokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        
        let pokemonCharacter = pokemonController.savedPokemon[indexPath.row]
        cell.textLabel?.text = pokemonCharacter.name
        

        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.pokemonController.savedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemon" {
                if let searchVC = segue.destination as? PokemonDetailViewController {
                    searchVC.pokemonController = pokemonController
                }
            } else if segue.identifier == "PokemonDetail" {
                if let detailVC = segue.destination as? PokemonDetailViewController,
                    let indexPath = tableView.indexPathForSelectedRow {
                    let pokemon = pokemonController.savedPokemon[indexPath.row]
                    detailVC.pokemon = pokemon
                    detailVC.pokemonController = pokemonController
                }
            }
        }

}
