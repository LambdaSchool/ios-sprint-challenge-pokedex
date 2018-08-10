//
//  PokemonSearchViewController.swift
//  ios-sprint-3
//
//  Created by Lambda-School-Loaner-11 on 8/10/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let key = "savePokemon"

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon : Pokemon?
    
    let pokemonController = PokemonController()
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonLabel: UILabel!
    
    @IBOutlet weak var pokemonID: UILabel!
    
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonAbility: UILabel!
    
    
    @IBAction func savePokemonButton(_ sender: Any) {
        
        guard let pokemon = pokemon else { return }
        
        pokemonLabel.text = pokemon.name
        pokemonID.text = pokemon.id
        pokemonType.text = pokemon.type
        pokemonAbility.text = pokemon.abilities
        
        let defaults = UserDefaults.standard
        defaults.setValue(pokemon, forKey: key)
        
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.performSearch(with: searchTerm) { (error) in
            if let error = error {
                NSLog("\(error)")
            }
            guard let pokemon = self.pokemon else { return }
            self.title = self.pokemon?.name
            self.pokemon = pokemon
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
}
