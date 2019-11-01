//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemon: Pokemon?
    var apiController = APIController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func updateViews() {
        
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = "\(pokemon.id)"
            typesLabel.text = "\(pokemon.types)"
            abilitiesLabel.text = "(pokemon.abilities)"
        }
    }
    
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
             guard let searchTerm = searchBar.text,
               !searchTerm.isEmpty else { return }
        
        apiController.fetchPokemonDetails(for: searchTerm) {_ in
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
}

