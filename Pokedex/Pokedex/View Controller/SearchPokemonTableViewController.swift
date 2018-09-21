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
    var searchTableViewCell: SearchTableViewCell?
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    
    // MARK: Perform Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = pokemonSearchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.performSearch(searchTerm: searchTerm, completion: { (pokemon,error) in
            DispatchQueue.main.async {
                if let error = error { // Check for a error
                    NSLog("Error performing search: \(error)")
                    return
                } else if let pokemon = pokemon { // If there is a pokemon then pass it to the Cell
                    self.view.endEditing(true)
                    self.tableView.reloadData()
                    self.searchTableViewCell?.pokemon = pokemon
                }
            }
        })
    }
    
    
    // MARK: - SearchTableViewCellDelegate
    
    func heySaveButtonTapped(on cell: SearchTableViewCell) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        let pokemon = pokemonController?.pokedex[index.row]
        
        if let pokemon = pokemon {
            pokemonController?.createPokemon(pokemon: pokemon)
        }
    }
}
