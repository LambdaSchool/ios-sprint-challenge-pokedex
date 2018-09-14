//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        // Configure the cell...
        let pokemon = self.pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = "ID: \(pokemon.id)"
        
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SearchSegue" {
            guard let destVC = segue.destination as? PokemonDetailViewController else {return}
            
            destVC.pokemonController = pokemonController
            
            destVC.tableViewController = self
            
        } else if segue.identifier == "ViewSegue" {
            
            guard let destVC = segue.destination as? PokemonViewController else {return}
            
            guard let indexP = tableView.indexPathForSelectedRow else {return}
            
             destVC.pokemon = pokemonController.pokemons[indexP.row]
            
        }
        
    }
    

}
