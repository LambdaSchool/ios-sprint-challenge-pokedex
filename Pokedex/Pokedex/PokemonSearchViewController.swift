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
        
        saveButton.setTitle("", for: .normal)
        
        nameLabel.text = ""
        idLabel.text = ""
        typesLabel.text = ""
        abilitiesLabel.text = ""
        searchBar.delegate = self

    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        saveButton.setTitle("Save", for: .normal)
        
        let abilitiesString = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        let typesString = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typesLabel.text = "types: \(typesString)"
        abilitiesLabel.text = "abitities: \(abilitiesString)"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        
        pokemonController?.searchPokemon(name: pokemonName.lowercased(), completion: { (_) in
            DispatchQueue.main.async {
                self.pokemon = self.pokemonController?.pokemon
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
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
