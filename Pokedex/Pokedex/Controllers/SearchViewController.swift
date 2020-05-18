//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var pokemon: Pokemon?
    var pokemonAPI: PokemonAPI?
    
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.delegate = self
       
    }
    
    
    @IBAction func saveButtonaTapped(_ sender: Any) {
        if let pokemonAPI = pokemonAPI,
            let pokemon = pokemon {
            pokemonAPI.addPokimon(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        self.title = pokemon.name.capitalizingFirstLetter()
        nameLabel.text = pokemon.name.capitalizingFirstLetter()
        idLabel.text = String(pokemon.id)
        typeLabel.text = pokemon.types.map { ($0 as String) }.compactMap({$0}).joined(separator: ", ").capitalizingFirstLetter()
        abilitiesLabel.text = pokemon.abilities.map { ($0 as String) }.compactMap({$0}).joined(separator: ", ").capitalizingFirstLetter()
        self.pokemonAPI?.fetchImage(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchName = searchBar.text else { return }
        searchBar.resignFirstResponder()
      pokemonAPI?.getPokemon(with: searchName) { (result) in
             let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    print(pokemon)
                    self.updateViews()
                }
            }
        }
    }
}
