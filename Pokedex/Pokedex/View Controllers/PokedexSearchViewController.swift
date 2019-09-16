//
//  PokedexSearchViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    //MARK: - Properties
    var pokemonAPI: PokemonAPIController?
    var pokemon: Pokemon?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
        resetViews()
    }
    
    //MARK: - Functions
    func resetViews() {
        pokemonNameLabel.text = ""
        pokemonIDLabel.text = ""
        pokemonTypesLabel.text = ""
        pokemonAbilitiesLabel.text = ""
        pokemonImageView.image = nil
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            print("No Pokemon data could be displayed.")
            return
        }
        
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "ID: \(String(describing: pokemon.id))"
        pokemonTypesLabel.text = "Types: \(pokemon.types)"
        pokemonAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
    }
    
}

extension PokedexSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initiateSearch()
        resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.text = ""
        resignFirstResponder()
    }
    
    func initiateSearch() {
        guard let searchText = pokemonSearchBar.text,
            let pokemonAPI = pokemonAPI else { return }
        
        pokemonAPI.getPokemon(for: searchText, completion: { error in
            if let error = error {
                print("Unable to find pokemon: \(error)")
            } else {
                DispatchQueue.main.async {
                    guard let pokemon = pokemonAPI.searchResult else { return }
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
        }
    )}
    
}
