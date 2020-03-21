//
//  PokeSearchViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController {
    
    var apiController = APIController()
    var pokemon: [Pokemon] = []
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //getPokemon()
        // Do any additional setup after loading the view.
    }
    

    func getPokemon() {
        guard let pokemon = searchBar.text,
        pokemon.isEmpty == false else { return }

        apiController.fetchPokemon(for: pokemon) { (result) in
                guard let pokemon = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
        }
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonLabel.text = pokemon.name
        idLabel.text = pokemon.id
        pokemonTypeLabel.text = pokemon.types
        abilitiesLabel.text = pokemon.abilities
        pokemonImageView.image = UIImage(named: pokemon.sprites)
    }

}

extension PokeSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        apiController.fetchPokemon(for: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.updateViews(with: pokemon)
            }
        }
    }
}
