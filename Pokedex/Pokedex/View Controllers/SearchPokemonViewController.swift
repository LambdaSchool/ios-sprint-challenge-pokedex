//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    var displayPokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController,
            let pokemon = pokemonController.searchedPokemon else {
            return
        }
        
        pokemonController.savePokemon(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews() {
        
    }
    


}

extension SearchPokemonViewController: UISearchBarDelegate {
    func searchBarClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
            !search.isEmpty else { return }
        
        pokemonController?.fetchPokemon(searchTerm: search) { error in
            if error == error {
                print("Pokemon could not be searched: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.displayPokemon = self.pokemonController?.searchedPokemon
                self.updateViews()
            }
        }
    }
}

extension UIImageView {
    func loadSprite(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
