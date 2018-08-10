//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        // save the pokemon to the pokemon controller
        pokemonController?.save(pokemon: pokemon)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm.count > 0 else { return }
        
        searchBar.resignFirstResponder()
        
        pokemonController?.fetchPokemon(withName: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error loading pokemons: \(error)")
            } else {
                if let pokemon = pokemon {
                    self.pokemon = pokemon
                    self.nameLabel?.text = "Name: \(pokemon.name)"
                    self.idLabel?.text = "ID: \(String(pokemon.id))"
                    self.abilityLabel?.text = "Abilities: \(pokemon.abilities.joined(separator: ", "))" // join all the strings of the array
                    self.typeLabel?.text = "Types: \(pokemon.types.joined(separator: ", "))"
                    
//                    get an image
                    if let imageURLString = pokemon.sprites["front_default"] as? String, let URL = URL(string: imageURLString) {
                        self.pokemonController?.fetchImage(url: URL, completion: { (image, error) in
                            if let image = image {
                                self.imageView.image = image
                            }
                        })
                    }
                }
            }
        })
    }

}
