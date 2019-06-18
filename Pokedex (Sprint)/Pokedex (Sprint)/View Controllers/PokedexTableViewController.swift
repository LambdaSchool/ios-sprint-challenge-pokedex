//
//  PokedexTableViewController.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    //Properties
    var pokemonControllerTVC = PokemonController()
    
    let segueIDSearch = "PokemonSearchSegue"
    let segueIDCell = "PokemonCellSegue"

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
        return pokemonControllerTVC.pokemonList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let pokeName = pokemonControllerTVC.pokemonList[indexPath.row].name
        cell.textLabel?.text = pokeName
        // Configure the cell...

        return cell
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIDSearch {
            let detailedVC = segue.destination as? PokemonSearchViewController
            detailedVC?.pokemonControllerSVC = pokemonControllerTVC
        }
        
        if segue.identifier == segueIDCell {
            let detailedVC = segue.destination as? PokemonDetailViewController
            detailedVC?.pokemonControllerDVC = pokemonControllerTVC
        
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
