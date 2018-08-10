//
//  PokedexSearchViewController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.getPokemon(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error getting a pokemon: \(error)")
            }
            
            self.searchedPokemon = pokemon
            DispatchQueue.main.async {
                self.pokemonNameLabel.text = self.searchedPokemon?.name.capitalized
            }
        })
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        if let pokemon = searchedPokemon {
            pokemonController?.pokemons.append(pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Properties
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    
    var searchedPokemon: Pokemon?
    var pokemonController: PokemonController?
}
