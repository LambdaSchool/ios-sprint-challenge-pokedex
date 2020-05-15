//
//  SearchAddPokemonViewController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class SearchAddPokemonViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameTitle: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController()
    var pokemon: Pokemon?
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self
    }
    
    //MARK: - Functions
    
    func updateViews(with pokemon: Pokemon) {
        
        let pokemon = pokemon
        pokemonNameTitle.text = pokemon.name
        pokemonTypesLabel.text = "Types: \(pokemon.types)"
        pokemonIdLabel.text = "ID: \(String(pokemon.id))"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
    }

    
    //MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        
        pokemonController.getPokemon(pokemonName: pokemonName) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    self.pokemon = pokemon
                }
                
                self.pokemonController.getPokemonImage(at: pokemon.sprites) { result in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage.image = image
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        
        pokemonController.createPokemon(pokemon: pokemon)
            
        navigationController?.popViewController(animated: true)
    }
}
