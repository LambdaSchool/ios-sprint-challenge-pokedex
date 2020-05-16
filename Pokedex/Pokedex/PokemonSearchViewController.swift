//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    let pokedexController = PokedexController()
    var pokedexControllers: PokedexController?
    var pokemonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getDetails() {
        guard let pokedexController = pokedexControllers,
            let pokemonName = self.pokemonName else { return }
        
        pokedexController.fetchDetails(for: pokemonName) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                pokedexController.fetchImage(at: pokemon.sprites) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage.image = image
                        }
                    }
                }
            }
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        pokemonTypesLabel.text = "Types: \(pokemon.types)"
        pokemonAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
    }
}

