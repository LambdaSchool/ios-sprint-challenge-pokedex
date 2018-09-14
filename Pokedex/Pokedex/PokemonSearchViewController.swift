//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Daniela Parra on 9/14/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typesLabel.text = String()
        abilitiesLabel.text = String()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        
        pokemon = pokemonController?.searchPokemon(name: pokemonName.lowercased(), completion: { (error) in
            if let error = error {
                print("can't search pokemon!: \(error)")
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var pokemonController: PokemonController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
