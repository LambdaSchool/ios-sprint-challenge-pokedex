//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pokemonController.pokemonArray[indexPath.row].name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let searchVC = segue.destination as? DetailViewController
            searchVC?.pokemonController = pokemonController
        } else if segue.identifier == "DetailSegue" {
            if let pokemonIndex = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as? DetailViewController
                detailVC?.pokemonController = pokemonController
                detailVC?.pokemon = pokemonController.pokemonArray[pokemonIndex.row]
            }
        }
    }


}
