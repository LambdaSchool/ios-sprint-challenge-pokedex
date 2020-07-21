//
//  PokeSearchViewController.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemonName: String?
    var pokemon: Pokemon?
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if let pokemon = pokemon {
            self.updateViews(with: pokemon)
            searchBar.isHidden = true
        }
    
    }
    
    func updateViews(with: Pokemon) {
        title = pokemon?.name.capitalized
        nameLabel.text = pokemon?.name.capitalized
     
        
    }
    
    
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        guard let pokemonController = pokemonController else { return }
        pokemonController.searchForPokemon(searchTerm) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    self.searchBar.isHidden = true
                    self.pokemon = pokemon
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("error: \(error)")
                }
            }
        }
       
        
    }
    
    
}



