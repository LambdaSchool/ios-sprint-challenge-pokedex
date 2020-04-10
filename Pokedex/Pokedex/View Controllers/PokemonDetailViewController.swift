//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    var pokemonController: PokemonController!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        // Unwrap Pokemon
        // call pokemoncontroller function
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            
            var stringType = ""
            for type in pokemon.types {
                stringType.append("Types: \(type.type.name) ")
            }
            typesLabel.text = stringType
            for ability in pokemon.abilities {
                stringType.append("Abilities: \(ability.ability.name)")
            }
        }
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // unrwap
        guard let searchBarText = searchBar.text else { return }
        pokemonController.fetchPokemon(with: searchBarText) { (result) in
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.updateViews()
            case .failure(let error):
                print(error)
            
            }
        }
    }
}
