//
//  PokeTableViewController.swift
//  PokeDeckCheat
//
//  Created by Austin Potts on 9/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokeTableViewController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController.getPokemon { (error) in
            if let error = error{
                NSLog("Error Performing Data Task: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

      let pokemon = apiController.pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name

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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokeSegue" {
            guard let pokeDetailVC = segue.destination as? PokeSearchViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let pokemon = apiController.pokemon[indexPath.row]
            pokeDetailVC.pokemon = pokemon
        }
        
        
    }
    

}

extension PokeTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else{return}
        
        apiController.searchForPokemon(with: searchTerm) {_ in 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
