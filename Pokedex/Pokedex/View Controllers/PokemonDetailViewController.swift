//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        abilityLabel.text = pokemon.abilities[0].ability.name
        typeLabel.text = pokemon.types[0].type.name
//        typeLabel.text = pokemon.types
//        abilityLabel.text = pokemon.abilities
    }

    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
}
