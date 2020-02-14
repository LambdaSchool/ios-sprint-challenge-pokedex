//
//  SearchVC+UISearchBarDelegate.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        
        apiController.searchForPokemon(searchTerm: searchTerm) { (_) in
            DispatchQueue.main.async {
                guard let pokemon = self.pokemon,
                    let pokemonController = self.pokemonController else { return }
                pokemonController.addPokemon(pokemon: pokemon)
                
            }
//            apiController.fetchSprite(at: searchTerm) { _ in
//                DispatchQueue.main.async {
//                    guard let imageString = pokemon.sprites else { return }
//
//                }
//            }
        }
    }
}
