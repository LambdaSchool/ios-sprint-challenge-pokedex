//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Jarren Campos on 3/20/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    var searchResultController: SearchResultController?
    var pokemon: Pokemon?
    var pathURL: String?
    //MARK: - IBOutlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func savePokemonTapped(_ sender: UIButton) {
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            pokemonName.text = pokemon.name
        }
    }
}
extension PokemonSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print(searchTerm)
        searchResultController?.performSearch(searchTerm: searchTerm){
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
}
}
