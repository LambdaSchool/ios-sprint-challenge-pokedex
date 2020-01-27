//
//  PokemonSearchTableViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class PokemonSearchTableViewController: UITableViewController {

    //MARK: IBOutlets
    @IBOutlet weak var pokemonSearchbar: UISearchBar!
    
    //MARK: Properties
    let pokemonApiController = PokemonAPIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchbar.delegate = self
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonApiController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

        let pokemon = pokemonApiController.searchResults[indexPath.row]
        
        cell.pokemonNameLabel.text = "#\(pokemon.id): \(pokemon.name)"
        cell.pokemonTypeLabel.text = "\(pokemon.types)"
        
        return cell
    }
    
    private func initiatePokemonSearch() {
        //Ensure that valid text is entered into pokemonSearchbar
        guard let pokemonName = pokemonSearchbar.text,
            pokemonSearchbar.text != nil else {
                print("Error with Pokemon Name search query")
                return
        }
        
        pokemonApiController.searchForPokemon(with: pokemonName.lowercased())
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonSearchTableViewController: UISearchBarDelegate {
   
    //Execute search when "Search" button on keyboard is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initiatePokemonSearch()
        pokemonSearchbar.resignFirstResponder()
    }
}
