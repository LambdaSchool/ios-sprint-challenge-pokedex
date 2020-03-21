//
//  PokemonSearchViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController!
    
    // MARK: - IBOutlets
    @IBOutlet weak var spriteNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteImage: UIImageView!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews(pokemon: pokemon)
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            self.title = pokemon.name
            spriteNameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = "\(pokemon.types)"
            abilitiesLabel.text = "\(pokemon.abilities)"
          
            
        }
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController.performSearch(searchTerm: searchTerm) { (result) in
            
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.updateViews(pokemon: pokemon)
            }
            self.pokemonController.fetchImage(at: pokemon.sprites.imageURL) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.spriteImage.image = image
            }
        }
    }
    }
}
