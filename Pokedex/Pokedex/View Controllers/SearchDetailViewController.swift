//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func search() {
        
    }
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
