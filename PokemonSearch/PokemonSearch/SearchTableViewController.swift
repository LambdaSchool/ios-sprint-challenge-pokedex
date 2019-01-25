//
//  SearchTableViewController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    var pokemonController = PokemonController()
    
   /* override func viewDidLoad() {
        super.viewDidLoad()
    }
    */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.searchForPokemon(with: searchTerm.lowercased()) { (pokemon, error) in
            DispatchQueue.main.async {
               // self.pokemons = pokemons ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! SearchTableViewCell

        let pokemon = self.pokemons[indexPath.row]
        cell.nameLabel.text = pokemon.name
        cell.idLabel.text = "ID: \(pokemon.id)"
        cell.abilitiesLabel.text = "Abilities: " + pokemon.abilities.map({ $0.ability.name }).joined(separator: ", ")
        cell.typeLabel.text = "Types: " + pokemon.types.map({ $0.type.name }).joined(separator: ", ")
        return cell
    }
    
    var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    

}
