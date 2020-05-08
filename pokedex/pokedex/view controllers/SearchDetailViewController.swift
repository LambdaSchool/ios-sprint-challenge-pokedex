//
//  SearchDetailViewController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        searchBar.delegate = self
    }
    

    func updateViews() {
        
    }

}

//  search bar delegate
extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarButtonTapped(searchBar: UISearchBar) {
        if let pokeName = searchBar.text,
            !pokeName.isEmpty {
            pokemonController?.fetchPokemon(pokemon: pokeName) { result in
                if let pokeName = try? result.get() {
                    DispatchQueue.main.async {
                        self.
                    }
                }
            }
        }
    }
}
