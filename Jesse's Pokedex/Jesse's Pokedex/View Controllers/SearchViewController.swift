//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    var matchingPokemon = [Pokemon]()
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon,
                let pokemonController = pokemonController else { return }
        pokemonController.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func updateViews(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonID.text = String(pokemon.id)
        pokemonType.text = pokemon.types.map({ $0.type.name.capitalized }).joined(separator: ", ")
        pokemonAbility.text = pokemon.abilities.map({ $0.ability.name.capitalized }).joined(separator: ", ")
        
        pokemonNameLabel.isHidden = false
        saveButton.isHidden = false
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
                let pokemonController = pokemonController else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    self.pokemon = pokemon
                }
                self.pokemonController!.fetchImage(at: pokemon.sprites.front_default) { (image) in
                    DispatchQueue.main.async {
                        self.pokemonImage.image = image
                    }
                }
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
}
