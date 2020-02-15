//
//  PokemonTableVC + Ext.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/15/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit



extension PokemonTableVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
        searchBar.text = ""
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
          searching = false
            tableView.reloadData()
        } else {
            searching = true
                let filteredPokemons = apiController.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                self.filteredPokemons = filteredPokemons
               
                tableView.reloadData()
        }
     
    }
}



extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
