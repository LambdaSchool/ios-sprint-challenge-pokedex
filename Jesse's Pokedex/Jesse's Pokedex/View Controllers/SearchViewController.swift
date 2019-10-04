//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    let pokemonController = PokemonController()
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                self.pokemonController.fetchImage(at: pokemon.image) { (image) in
                    DispatchQueue.main.async {
                        self.pokemonImage.image = image
                    }
                }
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonID.text = String(pokemon.id)
        pokemonType.text = pokemon.type
        pokemonAbility.text = pokemon.ability
        
        pokemonNameLabel.isHidden = false
        pokemonID.isHidden = false
        pokemonType.isHidden = false
        pokemonAbility.isHidden = false
        saveButton.isHidden = false
    }
    
    
    
}
