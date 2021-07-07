//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
              self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon Search"
        saveButton.isHidden = true
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let pokemon = pokemon else { return }
            
            let abilityString = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
            let typeString = pokemon.types.map { $0.type.name }.joined(separator: ", ")
            nameLabel.text = pokemon.name.capitalized
            idLabel.text = "ID:  \(pokemon.id)"
            typesLabel.text = "Types:  \(typeString.capitalized)"
            abilitiesLabel.text = "Abilities:  \(abilityString.capitalized)"
            saveButton.isHidden = false
            }
        }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        
        searchBar.text = ""
        idLabel.text = ""
        nameLabel.text = ""
        typesLabel.text = ""
        abilitiesLabel.text = ""
        saveButton.isHidden = true
        
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchForPokemon(with: searchTerm.lowercased()) { (pokemon, error) in
            self.pokemon = pokemon
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        idLabel.text = ""
        nameLabel.text = ""
        typesLabel.text = ""
        abilitiesLabel.text = ""
        saveButton.isHidden = true
    }
}

