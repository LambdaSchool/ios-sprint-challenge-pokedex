//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    //MARK: Properties
    var pokemon: Pokemon?
    var pokemonApiController: PokemonAPIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews() {
        guard let pokemon = pokemon, let pokemonApiController = pokemonApiController else { return }
        
        title = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(pokemon.formatPokemonTypes())"
        abilitiesLabel.text = "Abilities: \(pokemon.formatPokemonAbilities())"
        
        pokemonApiController.getPokemonSprite(with: pokemon.sprites.front_default) { (image, error) in
            guard error == nil else {
                print("Error trying to retrieve data: \(error)")
                return
            }
            
            guard let image = image else {
                print("Error building image object")
                return
            }
            
            DispatchQueue.main.async {
                self.pokemonImageView.image = image
            }
            
        }
        
    }

}
