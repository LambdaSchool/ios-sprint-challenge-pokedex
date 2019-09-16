//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
//        DispatchQueue.main.async {
//
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, let pokemonController = pokemonController else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
            } catch {
                print(error)
            }
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchTerm = searchBar.text, let pokemonController = pokemonController else { return }
//        
//        pokemonController.searchForPokemon(with: searchTerm) { result in
//            do {
//                let pokemon = try result.get()
//                DispatchQueue.main.async {
//                    self.updateViews(with: pokemon)
//                }
//            } catch {
//                print(error)
//            }
//        }
//    }
    
    func updateViews(with pokemon: Pokemon) {
        
        guard let pokemonController = pokemonController else { return }
        pokemonController.fetchImage(from: "\(pokemon.sprites[0])") { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(String(describing: pokemon.types[1]))"
        abilitiesLabel.text = "Abilities: \(String(describing: pokemon.abilities))"
    }
}
