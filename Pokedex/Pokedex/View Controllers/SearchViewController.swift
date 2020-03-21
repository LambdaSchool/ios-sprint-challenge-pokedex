//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var apiController: APIController!
    
    private var pokemonVC: PokemonViewController!

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonVC = segue.destination as? PokemonViewController else { return }
        self.pokemonVC = pokemonVC
    }
    
    @IBAction func saveButtonWasPressed(_ sender: Any) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        apiController.getPokemon(query) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemonVC.pokemon = pokemon
                }
            case .failure(let networkError):
                print("network error: \(networkError)")
            }
        }
    }
}
