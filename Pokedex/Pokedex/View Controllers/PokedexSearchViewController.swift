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
    @IBOutlet weak var savePokemon: UIButton!
    
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
        savePokemon.isHidden = true
    }
    
    func updateViews() {
        //Unwrap Pokemon optional to ensure an object is present
        guard let pokemon = pokemon else {
            print("No Pokemon data could be displayed.")
            return
        }
        
        //Store each name for Type and Ability into an array for use later
        var types: [String] = []
        var abilities: [String] = []
        
        for type in pokemon.types {
            types.append(type.type.name)
        }
        
        for ability in pokemon.abilities {
            abilities.append(ability.ability.name)
        }
        
        //Set UI Elements text values to unwrapped pokemon data
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "ID: \(String(describing: pokemon.id))"
        pokemonTypesLabel.text = "Types:"
        for type in types {
            pokemonTypesLabel.text?.append(" \(type.capitalized)")
        }
        pokemonAbilitiesLabel.text = "Abilities:"
        for ability in abilities {
            pokemonAbilitiesLabel.text?.append(" \(ability.capitalized)")
        }
        
        pokemonAPI?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        })
        
        savePokemon.isHidden = false
        
    }
    
    //Save pokemon to array in pokemonAPI for use with TableView and pop to rootviewcontroller
    @IBAction func savePokemonPressed(_ sender: Any) {
        guard let pokemonAPI = pokemonAPI else { return }
        guard let pokemon = pokemon else { return }
        
        pokemonAPI.savePokemon(for: pokemon)
        navigationController?.popViewController(animated: true)
    }
}

//Extension to handle Delegate methods for UISearchBarDelegate
extension PokedexSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.resignFirstResponder()
        initiateSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.text = ""
        pokemonSearchBar.resignFirstResponder()
    }
    
    //Unwrap search bar text and pokemonAPI and call .getPokemon method.
    func initiateSearch() {
        resetViews()
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
