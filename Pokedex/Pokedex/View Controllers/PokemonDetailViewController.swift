//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Vuk Radosavljevic on 8/10/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.isHidden = searchBarHidden
    }
    
    //MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var searchBarHidden = false
    
    //MARK: - Methods
    func updateViews() {
        DispatchQueue.main.async {
            if let pokemon = self.pokemon {
                self.pokemonNameLabel.text = pokemon.name
                self.idLabel.text = "ID: \(pokemon.id)"
            }

        }
    }
    
    
}


extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else {return}
        pokemonController?.searchForPokemon(with: searchTerm, completion: { (pokemon, error) in
            self.pokemon = pokemon
        })
    }
}
