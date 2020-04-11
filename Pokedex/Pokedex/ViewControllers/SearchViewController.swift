//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async { // Is this redundant given line 54?
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "\(pokemon.id)"
        pokemonAbilitiesLabel.text = pokemon.abilities.first?.ability.name
        pokemonTypesLabel.text = pokemon.types.first?.type.name
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm, completion: { (result) in
            if let pokemonSearchResult = try? result.get() {
                self.pokemon = pokemonSearchResult
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        })
    }
}
