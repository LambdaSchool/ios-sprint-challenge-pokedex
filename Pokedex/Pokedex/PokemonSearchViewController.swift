//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 3/20/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // Mark:- IBOutlets/Properties

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    // Mark:- Private Properties
    private var pokemonController = PokemonController()
    
    private var pokemon: [Pokemon] = []
    
    
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = pokemonSearchBar.text else { return }
        
        pokemonController.searchForPokemonWith(searchTerm: searchTerm) { (newPokemon) in
            self.pokemon = newPokemon
        }
    }
}
