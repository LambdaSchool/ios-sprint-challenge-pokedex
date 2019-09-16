//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    //MARK: - Properties
    var pokemon: Pokemon?
    var pokemonAPI: PokemonAPIController?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
        func updateViews() {
            //Unwrap Pokemon optional to ensure an object is present
            guard let pokemon = pokemon else {
                print("No Pokemon data could be displayed.")
                return
            }
            
            //Store each name for Type and Ability into an array for use later
            var types: [String] = []
            var abilities: [String] = []
            
            for type in pokemon.types {
                types.append(type.type.name)
            }
            
            for ability in pokemon.abilities {
                abilities.append(ability.ability.name)
            }
            
            //Set UI Elements text values to unwrapped pokemon data
            title = "\(pokemon.name.capitalized)"
            pokemonNameLabel.text = pokemon.name.capitalized
            pokemonIDLabel.text = "ID: \(String(describing: pokemon.id))"
            pokemonTypesLabel.text = "Types:"
            for type in types {
                pokemonTypesLabel.text?.append(" \(type.capitalized)")
            }
            pokemonAbilitiesLabel.text = "Abilities:"
            for ability in abilities {
                pokemonAbilitiesLabel.text?.append(" \(ability.capitalized)")
            }
            
            pokemonAPI?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                }
            })
            
        }

}
