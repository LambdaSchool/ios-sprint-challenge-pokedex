//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    var pokemonController: PokemonController?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    // Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
        
        updateViews()
    }

    // UI Methods
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.createPokemon(pokemon)
        
        navigationController?.popViewController(animated: true)
    }
    
    // UI Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = pokemonSearchBar.text, !searchText.isEmpty else { return }
        pokemonSearchBar.text = ""
        let spinnerView = UIViewController.displaySpinner(onView: self.view)
        
        pokemonController?.searchForPokemon(searchText: searchText.lowercased(), completion: { (_, pokemon) in
            guard let pokemon = pokemon else {
                UIViewController.removeSpinner(spinner: spinnerView)
                return
            }
            
            self.pokemon = pokemon
            self.pokemonController?.fetchImageFor(pokemon: pokemon, completion: { (_, pokemon) in
                UIViewController.removeSpinner(spinner: spinnerView)
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            })
        })
    }
    
    // MARK: Utility Methods
    private func updateViews() {
        guard isViewLoaded, let pokemon = pokemon else {
            title = "Pokemon Search"
            nameLabel.text = " "
            idLabel.text = " "
            typeLabel.text = " "
            abilityLabel.text = " "
            saveButton.isEnabled = false
            return
        }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.typesString)"
        abilityLabel.text = "Abilities: \(pokemon.abilityString)"
        saveButton.isEnabled = true
        if let imageData = pokemon.imageData {
            pokemonImageView.image = UIImage(data: imageData)
        } else {
            pokemonImageView.isHidden = true
        }
    }
    
}
