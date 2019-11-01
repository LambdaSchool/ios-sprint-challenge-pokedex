//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            pokemonIDLabel.text = "\(pokemon.id)"
            pokemonTypesLabel.text = pokemon.types.joined(separator: ", ")
            pokemonAbilitiesLabel.text = pokemon.abilities.joined(separator: ", ")
            showPokemonDetails(true)
        } else {
            showPokemonDetails(false)
        }
    }

    func showPokemonDetails(_ shouldShow: Bool) {
        nameLabel.isHidden = !shouldShow
        imageView.isHidden = !shouldShow
        pokemonIDLabel.isHidden = !shouldShow
        pokemonTypesLabel.isHidden = !shouldShow
        pokemonAbilitiesLabel.isHidden = !shouldShow
        
        idLabel.isHidden = !shouldShow
        typesLabel.isHidden = !shouldShow
        abilitiesLabel.isHidden = !shouldShow
    }
    
    private func search() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        searchBar.resignFirstResponder()
        
        pokemonController?.performSearch(for: searchTerm, completion: { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            } catch {
                if let error = error as? NetworkError {
                    print(error.rawValue)
                }
            }
        })
    }
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
