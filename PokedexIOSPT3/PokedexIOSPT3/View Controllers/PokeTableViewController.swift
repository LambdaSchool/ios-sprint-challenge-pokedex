//
//  PokeTableViewController.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class PokeTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokeList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokeTableViewCell else { return UITableViewCell() }
        
        let pokemon = pokemonController.pokeList?[indexPath.row]
        cell.pokemon = pokemon
        cell.pokemonController = pokemonController
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearch" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
//                searchVC.delegate = self
            }
        } else if segue.identifier == "ShowDetail" {
            if let detailVC = segue.destination as? SearchViewController,
                    let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemon = pokemonController.pokeList?[indexPath.row]
            }
        }
    }

}
