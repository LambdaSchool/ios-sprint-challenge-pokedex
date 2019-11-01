//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_204 on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    private let pokemonResultController = PokemonResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonResultController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = pokemonResultController.pokemons[indexPath.row].name
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                detailVC.pokemonResultController = self.pokemonResultController
            }
        } else if segue.identifier == "ShowDetailPokemonSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let detailVC = segue.destination as? PokemonDetailViewController {
                detailVC.pokemonResultController = self.pokemonResultController
                detailVC.pokemon = self.pokemonResultController.pokemons[indexPath.row]
            }
        }
    }
}
