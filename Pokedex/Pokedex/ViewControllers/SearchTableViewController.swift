//
//  SearchTableViewController.swift
//  Pokedex
//
//  Created by Jonathan T. Miles on 8/10/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        guard let pokemon = pokemonController?.pokedex[indexPath.row] else { return cell }
        cell.nameLabel.text = pokemon.name
        cell.idNumberLabel.text = "No. \(pokemon.id)"
        cell.abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        cell.typesLabel.text = "Types: \(pokemon.types)"

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Custom Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        pokemonController?.searchForPokemon(with: searchTerm, completion: { (pokedex, error) in
            self.pokedex = pokedex ?? []
        })
    }

    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokedex: [Pokemon] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
}
