//
//  PokeSearchViewController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController, UISearchBarDelegate {
    
    //Properties
    var pokemonController : PokemonController?
    var pokemonDataController : PokemonDataController?
    var pokemonSearchResult : PokemonSearchResult?
    var pokemon : Pokemon?
    
    //Outlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
   
    }
    
    //Function for Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, let pokemonController = pokemonController else {return}
        pokemonController.searchPokemon(searchText: searchText.lowercased(), completion: {(result) in
            let pokemonInfo = try? result.get()
            if let pokemon = pokemonInfo {
                DispatchQueue.main.async {
                    self.pokemonSearchResult = pokemon
                    self.updateViewsOnSearch()
                }
            }
        })
        }
    
    //Function to Save the Pokemon
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemonDataController = pokemonDataController, let pokemonName = searchBar.text, let pokemonSearchResult = pokemonSearchResult else {return}
        
        print(pokemonName)
        pokemonDataController.pokemonArray.append(Pokemon(pokemonName: pokemonSearchResult.name, pokemonImageString: pokemonSearchResult.sprites, pokemonAbilities: pokemonSearchResult.abilities, id: pokemonSearchResult.id, types: pokemonSearchResult.types))
        
        pokemonDataController.saveToPersistenceStore()
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    //Functions to Update the Views Accordingly
    func updateViewsOnSearch() {
        guard let pokemon = pokemonSearchResult, let pokemonController = pokemonController else {
            print("no pokemon")
            hideViews()
            title = "Pokemon Search"
            return }
        
        showViews()
        nameLabel.text = pokemon.name.capitalized
        abilitiesLabel.text = pokemon.getAbilitiesString()
        title = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = pokemon.getTypesString()
        
        pokemonController.fetchSprite(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
        
    }
    
    func updateViews() {
        guard let pokemon = pokemon, let pokemonController = pokemonController, let pokemonDataController = pokemonDataController else {
            hideViews()
            return
        }
        showViews()
        searchBar.isHidden = true
        title = pokemon.pokemonName.capitalizingFirstLetter()
        nameLabel.text = pokemon.pokemonName.capitalizingFirstLetter()
        abilitiesLabel.text = pokemonDataController.getAbilitiesString(pokemon: pokemon)
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = pokemonDataController.getTypesString(pokemon: pokemon)
        saveButton.isHidden = true
        pokemonController.fetchSprite(at: pokemon.pokemonImageString, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
    }
    
    func showViews() {
        nameLabel.isHidden = false
        abilitiesLabel.isHidden = false
        imageView.isHidden = false
        idLabel.isHidden = false
        saveButton.isHidden = false
        typesLabel.isHidden = false
    }
    
    func hideViews() {
        nameLabel.isHidden = true
        idLabel.isHidden = true
        abilitiesLabel.isHidden = true
        typesLabel.isHidden = true
        imageView.isHidden = true
        saveButton.isHidden = true
        }
}

//Extending String Class to hold a function to capitalize first letter of String (For Pokemon Name)
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
