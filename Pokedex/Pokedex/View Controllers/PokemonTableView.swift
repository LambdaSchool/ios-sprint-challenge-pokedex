//
//  PokemonTableView.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

class PokemonTableView: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { //Do the reload in the background of the main thread
            self.tableView.reloadData() //Reload the table with current data
        }
    }
    
    //Reference for easy manipulation below
    let pokeMaster = PokemonManager()
    
    //Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeMaster.pokeball.count
    }
    
    //Display the Table Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "pokeCell")
        
        cell.textLabel?.text = pokeMaster.pokeball[indexPath.row].name
        //cell.detailTextLabel?.text = PokemonManager().pokeball[indexPath.row].ty
        
        return cell
    }
    
    //Allow Swipe to Delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete { //If there's a swipe to delete...
            
           pokeMaster.pokeball.remove(at: indexPath.row) //Delete the Pokemon at the index that matches that row
        }
    }
    
    //Push data about selected Pokemon to other VCs through Segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Push this info to next VC
        if segue.identifier == "PokeSearch" { //If the navigation is to search
            let searchVC = segue.destination as! PokedexSearch //Make search VC easy to reference
            searchVC.pokeMaster = pokeMaster //Transfer the pokemonController info from THIS VC to the pokemonController declared in the Search VC for use.
        }
        if segue.identifier == "PokeView" { //If the navigation is to see Pokemon detail
            let detailVC = segue.destination as! SinglePokemonView //Make detail VC easy to reference below
            guard let indexPath = tableView.indexPathForSelectedRow else { return } //Unwrap the index path and make it easy to access in the Detail View
            detailVC.myPokemon = pokeMaster.pokeball[indexPath.row] //Set the current pokemon of the Detail VC to be the selected pokemon from the list view
        }
    }

    
}
