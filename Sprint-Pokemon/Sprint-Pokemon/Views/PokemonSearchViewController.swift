//
//  PokemonSearchViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController!
    
    // MARK: - IBOutlets
    @IBOutlet weak var spriteNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteImage: UIImageView!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            spriteNameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
//            typeLabel.text = pokemon.types
//            abilitiesLabel.text = pokemon.abilities
            
        }
        
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController.performSearch(searchTerm: searchTerm) { (error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.updateViews(pokemon: self.pokemon)
            }
        }
    }
}
