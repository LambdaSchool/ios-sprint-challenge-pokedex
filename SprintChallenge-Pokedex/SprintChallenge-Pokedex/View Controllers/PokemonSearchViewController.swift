//
//  PokemonSearchViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    var apiController = APIController()

    @IBOutlet weak var pokeSearch: UISearchBar!
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var searchResults: [PokeResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearch.delegate = self
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
