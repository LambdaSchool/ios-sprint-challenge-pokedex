//
//  File.swift
//  Pokedex
//
//  Created by Nikita Thomas on 10/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewController {
    
    // Search Bar
    let searchController = UISearchController(searchResultsController: nil)
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Model.shared.fetchAll {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var searchedResults: [Result] = []
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        searchedResults = Model.shared.allPokemon.filter({( result : Result) -> Bool in
            return result.name.lowercased().contains(searchText.lowercased())
        })
        for result in searchedResults {
            Model.shared.fetchEachPokemon(pokemonName: result.name)
            for pokemon in Model.shared.searchPokemon {
                if !pokemon.name.contains(searchText.lowercased()) {
                    guard let indexPath = Model.shared.searchPokemon.firstIndex(of: pokemon) else {return}
                    Model.shared.searchPokemon.remove(at: indexPath)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return Model.shared.searchPokemon.count
        }
        return Model.shared.pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon: Pokemon
    
        if isFiltering() {
            pokemon = Model.shared.searchPokemon[indexPath.row]
        } else {
            pokemon = Model.shared.pokemon[indexPath.row]
        }
        
        cell.nameLabel!.text = pokemon.name
        //cell.cellImageView.image = pokemon.sprites.
    
        return cell
    }
    
    
}

// Search Bar
extension SearchTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

