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
    
    
    override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        Model.shared.searchPokemon = Model.shared.pokemon.filter({( pokemon : Pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.searchPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        //Custom cell
        
        
        
        return cell
    }
    
    
}

// Search Bar
extension SearchTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

