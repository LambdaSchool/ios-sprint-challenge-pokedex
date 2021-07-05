//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 5/17/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var pokedexController: PokedexController?
    var showDetail = false
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        pokemonNameLabel.text = nil
        pokemonIDLabel.text = nil
        pokemonTypesLabel.text = nil
        pokemonAbilitiesLabel.text = nil
    }
    
    
    func updateViews() {
        guard let pokemon = pokemon, isViewLoaded,
        let imageURL = URL(string: pokemon.image) else { return }
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = String(pokemon.id)
        pokemonTypesLabel.text = pokemon.types
        pokemonAbilitiesLabel.text = pokemon.abilities
        pokemonImageView.loadURL(url: imageURL)
        
        if showDetail {
            searchBar.isHidden = true
            saveButton.isHidden = true
            title = pokemon.name.capitalized
        } else {
            searchBar.isHidden = false
            saveButton.isHidden = false
            title = "Pokemon Search"
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.lowercased(),
            !text.isEmpty,
        let pokedexController = pokedexController else { return }
        pokedexController.searchForPokemon(with: text) { (pokemon, error) in
            if let error = error {
                NSLog("Error fetching from API: \(error)")
                return
            }
            
            guard let pokemon = pokemon else { return }
            
            self.pokemon = pokemon
            
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokedexController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    

}
