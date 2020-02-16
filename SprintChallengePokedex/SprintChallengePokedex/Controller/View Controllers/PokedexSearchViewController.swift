//
//  PokedexSearchViewController.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeSpriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var apiController: APIController!
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    var typeString = ""
    var abilitiesString = ""
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private Methods
    private func updateViews(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        self.title = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        for (index, type) in pokemon.types.enumerated() {
            if index == 1 {
                typeString += " / " + type.type.name.capitalized
            } else {
                typeString += type.type.name.capitalized
            }
        }
        typesLabel.text = typeString
        for (index, ability) in pokemon.abilities.enumerated() {
            if index == pokemon.abilities.count - 1 {
                abilitiesString += ability.ability.name.capitalized
            } else {
                abilitiesString += ability.ability.name.capitalized + ", "
            }
        }
        abilitiesLabel.text = abilitiesString
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController, let pokemon = pokemon else { return }
        pokemonController.pokemon.append(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
}

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - SearchBar Delegate Extension
extension PokedexSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text, !term.isEmpty, let apiController = apiController else { return }
        apiController.searchForPokemon(with: term.lowercased()) { [weak self] result in
            guard let self = self else { return }
            if let pokemon = try? result.get() {
                self.pokemon = pokemon
                self.updateViews(with: pokemon)
                apiController.fetchImage(at: pokemon.sprites.frontDefault) { result in
                    if let image = try? result.get() {
                        self.pokeSpriteImageView.image = image
                    }
                }
            }
        }
    }
}
