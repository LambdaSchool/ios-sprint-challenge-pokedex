//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    var pokemonController = PokemonController()
    var pokemon: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.performSearch(with: searchTerm) { _ in
            DispatchQueue.main.async {
                //update labels and image w/ pokemon
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
}
