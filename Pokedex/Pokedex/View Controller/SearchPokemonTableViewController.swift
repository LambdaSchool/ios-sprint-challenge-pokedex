//
//  SearchPokemonTableViewController.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class SearchPokemonTableViewController: UITableViewController, SearchTableViewCellDelegate, UISearchBarDelegate {
    
    // MARK: - Properties
    
    var pokemonController: PokemonController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController?.pokedex.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        guard let pokemon = pokemonController?.pokedex[indexPath.row] else { return cell }
        
        cell.pokemon = pokemon
        cell.cellDelegate = self
        
        return cell
    }
    
    // MARK: - SearchTableViewCellDelegate
    
    func heySaveButtonTapped(on cell: SearchTableViewCell) {
//        pokemonController?.createPokemon(pokemon: <#T##Pokemon#>)
    }
    
    // MARK: Perform Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = pokemonSearchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.performSearch(searchTerm: searchTerm, completion: { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("Error performing search: \(error)")
                    return
                } else {
                    self.tableView.reloadData()
                    self.view.endEditing(true)
                }
            }
        })
    }
    
}
