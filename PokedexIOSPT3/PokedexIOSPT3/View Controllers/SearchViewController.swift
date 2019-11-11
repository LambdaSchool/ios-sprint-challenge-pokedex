//
//  SearchViewController.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
    }
    
    @IBAction func savePokemon(_ sender: UIBarButtonItem) {
        if let pokemon = pokemon {
            pokemonController?.pokeList?.append(pokemon)
        }
    }
    
    private func updateViews(with pokemon: Pokemon) {
        pokemonController?.fetchImage(from: "\(pokemon.sprites.front_default)") { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        guard let pokemonController = pokemonController else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews(with: pokemon)
                }
            } catch {
                print(error)
            }
        }
    }
}
