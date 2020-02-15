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

        apiController.searchForPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                do{
                    self.pokemon = try result.get()
                } catch{
                    NSLog("\(error)")
                }
                guard let pokemon = self.pokemon else { return }
                self.apiController.fetchSprite(pokemon: pokemon) { (result) in
                        DispatchQueue.main.async {
                            do{
                                self.pokemonImage.image = try result.get()
                            } catch {
                                NSLog("\(error)")
                            }
                        }
                    }
                }
            }
        }     
}
