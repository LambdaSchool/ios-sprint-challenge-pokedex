//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    private var pokemonNames: [String] = [] {
           didSet {
               tableView.reloadData()
           }
       }
       let pokemonController = PokemonController()
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.searchResults[indexPath.row]
    
        cell.textLabel?.text = pokemon.name.capitalized
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "pokemonDetails" {
            guard let searchVC = segue.destination as? SearchPokemonViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard indexPath.row < pokemonController.searchResults.count else { return }
            
        let pokemon = self.pokemonController.searchResults[indexPath.row]
            searchVC.pokemonController = self.pokemonController
            searchVC.pokemon = pokemon
            
        } else if segue.identifier == "searchPokemonSegue" {
            guard let searchVC = segue.destination as? SearchPokemonViewController else { return }
            
            searchVC.pokemonController = self.pokemonController
        }
        
    }
   

}
