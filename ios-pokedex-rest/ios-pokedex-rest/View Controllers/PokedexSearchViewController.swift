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
        
        pokemonAbilitiesLabel.text = ""
        pokemonTypesLabel.text = ""
        pokemonID.text = ""
        pokemonNameLabel.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.getPokemon(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error getting a pokemon: \(error)")
            }
            
            self.searchedPokemon = pokemon
            DispatchQueue.main.async {
                if let pokemon = self.searchedPokemon {
                    self.pokemonNameLabel.text = pokemon.name.capitalized
                    self.pokemonID.text = "ID: " + String(pokemon.id)
                    self.pokemonTypesLabel.text = "Types: " + pokemon.types.map { $0.type.name }.joined(separator: ", ")
                    self.pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
                }
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
    @IBOutlet var pokemonID: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    
    var searchedPokemon: Pokemon?
    var pokemonController: PokemonController?
}
