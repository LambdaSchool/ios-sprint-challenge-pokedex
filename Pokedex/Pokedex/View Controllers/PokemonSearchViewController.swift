//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchResultsUpdating {
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = search
        definesPresentationContext = true
        
        updateViews()
    }

    func updateViews() {
        guard isViewLoaded, let pokemon = pokemon else {
            title = "Pokemon Search"
            nameLabel.text = " "
            idLabel.text = " "
            abilitiesLabel.text = " "
            saveButton.isEnabled = false
            return
        }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.typesString)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilityString)"
        saveButton.isEnabled = true
        if let imageData = pokemon.imageData {
            pokemonImageView.image = UIImage(data: imageData)
        } else {
            pokemonImageView.isHidden = true
        }
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.createPokemon(pokemon)
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        
        pokemonController?.searchForPokemon(searchText: text.lowercased(), completion: { (_, pokemon) in
            guard let pokemon = pokemon else { return }
            
            self.pokemon = pokemon
            self.pokemonController?.fetchImageFor(pokemon: pokemon, completion: { (_, pokemon) in
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            })
        })
    }

}
