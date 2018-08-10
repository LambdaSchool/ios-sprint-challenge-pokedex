//
//  PokemonSearchViewController.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    
    // MARK: - Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchInput = searchBar.text else { return }
        
        pokemonController?.fetchPokemons(for: searchInput, completion: { (error) in
            if let error = error {
                NSLog("Error while fetching pokemon: \(error)")
                return
            }
            //print(self.pokemonController?.pokemon)
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    private func updateViews() {
        
        if let pokemon = pokemon {
            title = pokemon.name
            nameTextLabel?.text = pokemon.name
            identifierTextLabel?.text = "ID: \(String(pokemon.id))"
            typeTextLabel?.text = "Types: "
            abilitiesTextLabel?.text = "Abilities: "
            buttonTextLabel?.setTitle("Save Pokemon", for: .normal)
        } else {
            title = "Pokemon Search"
            nameTextLabel?.text = ""
            identifierTextLabel?.text = ""
            typeTextLabel?.text = ""
            abilitiesTextLabel?.text = ""
            buttonTextLabel?.setTitle("", for: .normal)
        }
    }
    
    
    // MARK: - Properties
    var pokemon: Pokemon? {
        return pokemonController?.pokemon
    }
    
    var pokemonController: PokemonController?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var identifierTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    @IBOutlet weak var abilitiesTextLabel: UILabel!
    @IBOutlet weak var buttonTextLabel: UIButton!
}
