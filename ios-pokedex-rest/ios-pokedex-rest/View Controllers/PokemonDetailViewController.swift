//
//  PokemonDetailViewController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemon {
            title = pokemon.name.capitalized
            pokemonNameLabel.text = pokemon.name.capitalized
            pokemonIDLabel.text = String(pokemon.id)
            pokemonTypesLabel.text = pokemon.types.map { $0.type.name }.joined(separator: ", ")
            pokemonAbilitiesLabel.text = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        }
    }
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
}
