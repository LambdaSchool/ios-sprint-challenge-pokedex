//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            if pokemon?.name == pokemon?.name {
                title = pokemon?.name
                nameLabel.text = pokemon?.name
                idLabel.text = pokemon?.id
                typesLabel.text = pokemon?.types
                abilitiesLabel.text = pokemon?.abilities
            } else {
                title = "Pokemon Search"
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
//        pokemonController?.searchForPokemon(with: searchTerm, completion: { (pokemon, error) in
//            
//        })
        
    }
    
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        
    }
    
}
