//
//  PokemonTableViewController.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    //Properties
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
        return pokemonController.pokemonList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name

        return cell
    }
   

   

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "PokemonSearchSegue" {
            
            guard let searchVC = segue.destination as? PokemonSearchViewController else { return }
            searchVC.pokemonController = pokemonController
            
        } else if segue.identifier == "PokemonDetailSegue" {
            
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            detailVC.pokemonController = pokemonController
            
            guard let selected = self.tableView.indexPathForSelectedRow?.row else { return }
            detailVC.pokemon = pokemonController.pokemonList[selected]
        }
        // Pass the selected object to the new view controller.
    }

}
