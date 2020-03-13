//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = pokemonController.pokedex[indexPath.row].name

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonSearch" {
            if let PokemonSearchVC = segue.destination as? PokemonSearchViewController {
                PokemonSearchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "ShowPokemonDetail" {
            guard let PokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            guard let selected = tableView.indexPathForSelectedRow else { return }
            PokemonDetailVC.pokemon = pokemonController.pokedex[selected.row]
        }
    }

}
