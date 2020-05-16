//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    var pokedexController: PokedexController?
    var pokemonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
    }
    
    func getDetails() {
        guard let pokedexController = pokedexController,
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
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        pokemonTypesLabel.text = "Types: \(pokemon.types)"
        pokemonAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
    }
}
