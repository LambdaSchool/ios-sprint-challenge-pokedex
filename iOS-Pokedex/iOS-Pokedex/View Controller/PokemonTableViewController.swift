//
//  PokemonTableViewController.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemon()
        updateViews()
    }
    
    //Variables
    var pokemonController = PokemonController()
    
    //Functions
    func updateViews() {
        print("Updating Views")
        tableView.reloadData()
        print("Views Updated")
    }
    
    func getPokemon() {
        pokemonController.getPokemon {
            DispatchQueue.main.async {
                guard let pokemon = self.pokemonController.pokemon else { return }
                for i in pokemon.results {
                    print(i.name)
                }
            }
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonAdded.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        cell.textLabel?.text =  pokemonController.pokemonAdded[indexPath.row].name

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard let destination = segue.destination as? PokemonViewController else { return }
        
        if identifier == "searchSegue" {
            destination.delegate = self
            destination.pokemonController = pokemonController
        } else if identifier == "modifySegue" {
            destination.delegate = self
            destination.pokemonController = pokemonController
            if let row = tableView.indexPathForSelectedRow?.row {
                destination.selectedRow = row
                destination.displayedPokemon = pokemonController.pokemonAdded[row]
            }

        }
        
    }
    

}
