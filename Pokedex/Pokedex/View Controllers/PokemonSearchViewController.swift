//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()

    }
    
    func updateViews() {
        if let pokemon = pokemonController?.pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = pokemon.types.first?.type.name
            abilityLabel.text = pokemon.abilities.first?.ability.name
        } else {
            title = "Pokemon Search"
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilityLabel.text = ""
        }
    }
    
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        guard let pokemon = pokemonController?.pokemon else { return }
        pokemonController?.create(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetch(searchName: searchTerm, completion: { (error) in
            if let error = error {
                NSLog("Error fetching: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
        
    }

    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
}
