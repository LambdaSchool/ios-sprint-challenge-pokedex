//
//  PokemonSearchTableViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 9/21/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokemonSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let pokemonController = PokemonController()
    var pokedex: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokedex.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! PokemonSearchTableViewCell
        
        let pokemon = pokedex[indexPath.row]
        
        cell.nameLabel.text = pokemon.name
        cell.idLabel.text = pokemon.id
        cell.abilitiesLabel.text = pokemon.abilities
        cell.typesLabel.text = pokemon.types
        
        
        return cell
    }

    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    
    /*
     // MARK: - Navigation ///// Segue Name - toSearchBar /////
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (pokedex, error) in
            self.pokedex = self.pokemonController.pokedex
        }
    }
    
}
