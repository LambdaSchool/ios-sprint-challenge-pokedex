//
//  SearchViewController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonController: PokemonController!
    
    var pokemon: Pokemon?
    
    var pokemonDetailViewController: PokemonDetailViewController? {
        didSet {
            if let pokemon = pokemon {
                pokemonDetailViewController?.pokemon = pokemon
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedDetailSegue" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                pokemonDetailViewController = detailVC
            }
            
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        pokemonController.fetchPokemon(name: text) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.pokemonDetailViewController?.pokemon = pokemon
                }
                self.pokemonController.fetchImage(at: pokemon.sprite.frontDefault) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonDetailViewController?.imageView.image = image
                        }
                    }
                    
                }
                
            } catch {
                if let error = error as? NetworkError {
                    switch error {
                        case .badData:
                            NSLog("Bad Data")
                        case .noDecode:
                            NSLog("No Decode")
                        case .otherError:
                            NSLog("Network Error")
                        case .notFound:
                            NSLog("Pokemon not found")
                        default:
                            break
                    }
                }
            }
        }
        
    }
}
