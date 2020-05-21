//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.delegate = self
        pokemonSearchBar.becomeFirstResponder()
    }
    
    
    // Mark: IBOutlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // Properties
    var pokemonAPIController: PokemonAPIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    // Mark: IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonAPIController?.savePokemon(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         guard let searchBarText = searchBar.text else { return }
        pokemonAPIController?.fetchPokemon(searchTerm: searchBarText, completion: { (results) in
            guard let pokemon = try? results.get() else { return }
            
            DispatchQueue.main.sync {
                self.pokemon = pokemon
                self.saveButton.isHidden = false
            }
     })
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let pokemon = pokemon {
            title = "Pokemon Search"
            
            
            pokemonNameLabel.text = pokemon.name
            
            pokemonAbilitiesLabel.text = ""
            
            
            pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
            
            pokemonTypesLabel.text = ""
            pokemonTypesLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
            pokemonIdLabel.text = "ID: \(pokemon.id)"
            
            self.pokemonAPIController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (image) in
                DispatchQueue.main.sync {
                    self.pokemonImageView.image = image
                }
            })
            
            
        }
    }
    
}

